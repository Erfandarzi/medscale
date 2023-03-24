import os
import numpy as np
import torch
from torchvision.datasets import ImageFolder, VisionDataset
from torch import device
from torch.utils.data import DataLoader 
from torchvision import datasets, transforms
from federatedscope.register import register_data

# Run with mini_graph_dt:
# python federatedscope/main.py --cfg \
# federatedscope/gfl/baseline/mini_graph_dc/fedavg.yaml --client_cfg \
# federatedscope/gfl/baseline/mini_graph_dc/fedavg_per_client.yaml
# Test Accuracy: ~0.7

    

   
def load_my_data(config, client_cfgs=None):
      from federatedscope.core.data import BaseDataTranslator


      # class lungdataset(VisionDataset):
 

      transform = transforms.Compose([transforms.Resize(100),
                                transforms.CenterCrop(100),
                                transforms.ToTensor(),
                                transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])
      data  = ImageFolder('data/retinotherapy/', transform=transform) 
     
     

      translator = BaseDataTranslator(config, client_cfgs) 
      fs_data = translator(data )
      return fs_data, config



def call_my_data(config, client_cfgs):
     if config.data.type == "retinotherapy":
         data, modified_config = load_my_data(config, client_cfgs)
         return data, modified_config

register_data("retinotherapy", call_my_data)


