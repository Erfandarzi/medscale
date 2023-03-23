import copy

from medscale.core.trainers.torch_trainer import GeneralTorchTrainer
from medscale.core.optimizer import wrap_regularized_optimizer
from typing import Type
import torch
from torch.quantization.observer import  MovingAverageMinMaxObserver 
from torch.quantization import QConfig , prepare_qat
from torch.quantization.fake_quantize import FakeQuantize

def quantized(model,level):
        qconfig = QConfig(
            activation = FakeQuantize.with_args(observer=MovingAverageMinMaxObserver),
            weight = FakeQuantize.with_args(
                observer=MovingAverageMinMaxObserver,
                quant_min=-1*level, quant_max=level,
                dtype=torch.qint8)
        )
        model_fp32 =model()
        model_fp32.train()
        model_fp32.qconfig = qconfig
        model_fp32_prepared = prepare_qat(model_fp32)
        model_fp32_prepared.eval()
        model_int8 = convert(model_fp32_prepared)
        return model_int8

def wrap_MedCalTrainer(
        base_trainer: Type[GeneralTorchTrainer]) -> Type[GeneralTorchTrainer]:
    """
    Build a `pMedCalTrainer` with a plug-in manner, by registering new
    functions into specific `BaseTrainer`
 
    """

    # ---------------- attribute-level plug-in -----------------------
    init_MedCal_ctx(base_trainer)

    # ---------------- action-level plug-in -----------------------
    base_trainer.register_hook_in_train(
        new_hook=_hook_on_fit_start_set_local_para_tmp,
        trigger="on_fit_start",
        insert_pos=-1)
    base_trainer.register_hook_in_train(
        new_hook=_hook_on_epoch_end_update_local,
        trigger="on_epoch_end",
        insert_pos=-1)
    base_trainer.register_hook_in_train(new_hook=_hook_on_fit_end_update_local,
                                        trigger="on_fit_end",
                                        insert_pos=-1)

    base_trainer.register_hook_in_train(new_hook=_hook_on_batch_end_flop_count,
                                        trigger="on_batch_end",
                                        insert_pos=-1)
    base_trainer.register_hook_in_train(new_hook=_hook_on_epoch_end_flop_count,
                                        trigger="on_epoch_end",
                                        insert_pos=-1)

    # for "on_batch_start" trigger: replace the original hooks into new ones
    # of MedCal
    # 1) cache the original hooks for "on_batch_start"
    base_trainer.ctx.original_hook_on_batch_start_train = \
        base_trainer.hooks_in_train["on_batch_start"]
    # 2) replace the original hooks for "on_batch_start"
    base_trainer.replace_hook_in_train(
        new_hook=_hook_on_batch_start_init_MedCal,
        target_trigger="on_batch_start",
        target_hook_name=None)

    return base_trainer


def init_MedCal_ctx(base_trainer):
    """
    init necessary attributes used in MedCal,
    some new attributes will be with prefix `MedCal` optimizer to avoid
    namespace pollution

    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.optimizer_for_global_model``  False
        ==================================  ===========================

    """
    ctx = base_trainer.ctx
    cfg = base_trainer.cfg

    # MedCal finds approximate model with K steps using the same data batch
    # the complexity of each MedCal client is K times the one of FedAvg
    ctx.MedCal_K = cfg.personalization.K
    ctx.num_train_epoch *= ctx.MedCal_K
    ctx.MedCal_approx_fit_counter = 0
    ctx.MedCal_batch_size=cfg.dataloader.batch_size	
    ctx.MedCal_resolution=ctx.MedCal_batch_size
    

    # the local_model_tmp is used to be the referenced parameter when
    # finding the approximate \theta in paper
    # will be copied from model every run_routine
    ctx.MedCal_local_model_tmp = None


def _hook_on_fit_start_set_local_para_tmp(ctx):
    """
    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.optimizer``                   Wrapped by \
        ``wrap_regularized_optimizer`` and set compared parameter group
        ``ctx.MedCal_outer_lr``             Initialize to \
        ``ctx.cfg.train.optimizer.lr``
        ``ctx.MedCal_local_model_tmp``      Copy from ``ctx.model``
        ==================================  ===========================
    """
    # the optimizer used in MedCal is based on Moreau Envelopes regularization
    # besides, there are two distinct lr for the approximate model and base
    # model
    ctx.optimizer = wrap_regularized_optimizer(
        ctx.optimizer, ctx.cfg.personalization.regular_weight)
    for g in ctx.optimizer.param_groups:
        g['lr'] = ctx.cfg.personalization.lr
    ctx.MedCal_outer_lr = ctx.cfg.train.optimizer.lr

    ctx.MedCal_local_model_tmp_quant = copy.deepcopy(ctx.model)
    ctx.MedCal_local_model_tmp  = copy.deepcopy(quantized(ctx.MedCal_local_model_tmp_quant, ctx.MedCal_resolution)) 
    # set the compared model data, then the optimizer will find approximate
    # model using trainer.cfg.personalization.lr
    compared_global_model_para = [{
        "params": list(ctx.MedCal_local_model_tmp.parameters())
    }]
    ctx.optimizer.set_compared_para_group(compared_global_model_para)


def _hook_on_batch_start_init_MedCal(ctx):
    """
    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.data_batch_cache``            Copy from ``ctx.data_batch``
        ``ctx.MedCal_approx_fit_counter``   Count to refresh data every K step
        ==================================  ===========================
    """
    # refresh data every K step
    if ctx.MedCal_approx_fit_counter == 0:
        if ctx.cur_mode == "train":
            for hook in ctx.original_hook_on_batch_start_train:
                hook(ctx)
        else:
            for hook in ctx.original_hook_on_batch_start_eval:
                hook(ctx)
        ctx.data_batch_cache = copy.deepcopy(ctx.data_batch)
    else:
        # reuse the data_cache since the original hook `_hook_on_batch_end`
        # will clean `data_batch`
        ctx.data_batch = copy.deepcopy(ctx.data_batch_cache)
    ctx.MedCal_approx_fit_counter = (ctx.MedCal_approx_fit_counter +
                                     1) % ctx.MedCal_K


def _hook_on_batch_end_flop_count(ctx):
    """
    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.monitor``                     Monitor total flops
        ==================================  ===========================
    """
    # besides the normal forward flops, MedCal introduces
    # 1) the regularization adds the cost of number of model parameters
    ctx.monitor.total_flops += ctx.monitor.total_model_size / 2


def _hook_on_epoch_end_flop_count(ctx):
    """
    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.monitor``                     Monitor total flops
        ==================================  ===========================
    """
    # due to the local weight updating
    ctx.monitor.total_flops += ctx.monitor.total_model_size / 2


def _hook_on_epoch_end_update_local(ctx):
    """
    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.model``                       Update parameters by \
        ``ctx.MedCal_local_model_tmp``
        ``ctx.optimizer``                   Set compared parameter group
        ==================================  ===========================
    """
    # update local weight after finding approximate theta
    for client_param, local_para_tmp in zip(
            ctx.model.parameters(), ctx.MedCal_local_model_tmp.parameters()):
        local_para_tmp.data = local_para_tmp.data - \
                              ctx.optimizer.regular_weight * \
                              ctx.MedCal_outer_lr * (local_para_tmp.data -
                                                     client_param.data)

    # set the compared model data, then the optimizer will find approximate
    # model using trainer.cfg.personalization.lr
    compared_global_model_para = [{
        "params": list(ctx.MedCal_local_model_tmp.parameters())
    }]
    ctx.optimizer.set_compared_para_group(compared_global_model_para)


def _hook_on_fit_end_update_local(ctx):
    """
    Note:
      The modified attributes and according operations are shown below:
        ==================================  ===========================
        Attribute                           Operation
        ==================================  ===========================
        ``ctx.model``                       Update parameters by
        ``ctx.MedCal_local_model_tmp``
        ``ctx.MedCal_local_model_tmp``      Delete
        ==================================  ===========================
    """
    for param, local_para_tmp in zip(ctx.model.parameters(),
                                     ctx.MedCal_local_model_tmp.parameters()):
        param.data = local_para_tmp.data

    del ctx.MedCal_local_model_tmp
