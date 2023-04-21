# Copyright (c) Alibaba, Inc. and its affiliates.
import unittest

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
from medscale.core.auxiliaries.data_builder import get_data
from medscale.core.auxiliaries.utils import setup_seed
from medscale.core.auxiliaries.logging import update_logger
from medscale.core.configs.config import global_cfg
from medscale.core.auxiliaries.runner_builder import get_runner
from medscale.core.auxiliaries.worker_builder import get_server_cls, get_client_cls
<<<<<<< HEAD
=======
=======
from medscale.core.auxiliaries.data_builder import get_data
from medscale.core.auxiliaries.utils import setup_seed
from medscale.core.auxiliaries.logging import update_logger
from medscale.core.configs.config import global_cfg
from medscale.core.auxiliaries.runner_builder import get_runner
from medscale.core.auxiliaries.worker_builder import get_server_cls, get_client_cls
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f


class ToyLRTest(unittest.TestCase):
    def setUp(self):
        print(('Testing %s.%s' % (type(self).__name__, self._testMethodName)))

    def set_config_standalone(self, cfg, make_global_eval=False):
        backup_cfg = cfg.clone()

        import torch
        cfg.use_gpu = torch.cuda.is_available()
        cfg.federate.mode = 'standalone'
        cfg.federate.total_round_num = 20
        cfg.federate.make_global_eval = make_global_eval
        cfg.federate.client_num = 5
        cfg.eval.freq = 10
        cfg.data.type = 'toy'
        cfg.trainer.type = 'general'
        cfg.model.type = 'lr'
        cfg.finetune.before_eval = True
        cfg.finetune.local_update_steps = 5

        return backup_cfg

    def test_toy_example_standalone(self):
        init_cfg = global_cfg.clone()
        backup_cfg = self.set_config_standalone(init_cfg)
        setup_seed(init_cfg.seed)
        update_logger(init_cfg, True)

        data, modified_config = get_data(init_cfg.clone())
        init_cfg.merge_from_other_cfg(modified_config)

        self.assertIsNotNone(data)

        Fed_runner = get_runner(data=data,
                                server_class=get_server_cls(init_cfg),
                                client_class=get_client_cls(init_cfg),
                                config=init_cfg.clone())
        self.assertIsNotNone(Fed_runner)
        test_best_results = Fed_runner.run()
        print(test_best_results)
        init_cfg.merge_from_other_cfg(backup_cfg)
        self.assertLess(
            test_best_results["client_summarized_weighted_avg"]['test_loss'],
            0.3)


if __name__ == '__main__':
    unittest.main()
