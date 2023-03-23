from medscale.register import register_trainer
from medscale.core.trainers import BaseTrainer


def call_sam_trainer(trainer_type):
    if trainer_type == 'sam_trainer':
        from medscale.contrib.trainer.sam import SAMTrainer
        return SAMTrainer


register_trainer('sam_trainer', call_sam_trainer)
