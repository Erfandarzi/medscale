import os
import numpy as np
import torch
from torchvision.datasets import ImageFolder
from torch import device
from torchvision import datasets, transforms
from federatedscope.register import register_data

# Run with mini_graph_dt:
# python federatedscope/main.py --cfg \
# federatedscope/gfl/baseline/mini_graph_dc/fedavg.yaml --client_cfg \
# federatedscope/gfl/baseline/mini_graph_dc/fedavg_per_client.yaml
# Test Accuracy: ~0.7

    

   
def load_my_data(config, client_cfgs=None):
      transform=transforms.Compose([
        transforms.RandomRotation(10),      # rotate +/- 10 degrees
        transforms.RandomHorizontalFlip(),  # reverse 50% of images
        transforms.Resize(100),             # resize shortest side
        transforms.CenterCrop(100),   
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406],
                             [0.229, 0.224, 0.225])])
      dataset_train = ImageFolder('data/MRI/train/', transform=transform)
      dataset_test = ImageFolder('data/MRI/test/', transform=transform) 
      translator = BaseDataTranslator(config, client_cfgs)
      fs_data = translator([dataset_train, [], dataset_test])
      return fs_data, config


def call_my_data(config):
     if config.data.type == "MRI":
         data, modified_config = load_my_data(config)
         return data, modified_config
    

