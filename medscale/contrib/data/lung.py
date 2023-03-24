import os
import numpy as np
import torch
from torchvision.datasets import ImageFolder, VisionDataset
from torch import device
from torch.utils.data import DataLoader 
from torchvision import datasets, transforms
from medscale.register import register_data

# Run with mini_graph_dt:
# python medscale/main.py --cfg \
# medscale/gfl/baseline/mini_graph_dc/fedavg.yaml --client_cfg \
# medscale/gfl/baseline/mini_graph_dc/fedavg_per_client.yaml
# Test Accuracy: ~0.7

    

   
def load_my_data(config, size,client_cfgs=None):
      from medscale.core.data import BaseDataTranslator


      transform=transforms.Compose([
        transforms.RandomRotation(10),      # rotate +/- 10 degrees
        transforms.RandomHorizontalFlip(),  # reverse 50% of images
        transforms.Resize(size), 
        transforms.CenterCrop(size),             # resize shortest side
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406],
                             [0.229, 0.224, 0.225])])
      data_train = ImageFolder('data/lung/train', transform=transform) 
      data_test = ImageFolder('data/lung/train', transform=transform) 
      # data_train =  DataLoader(data_train)
      # data_train =   DataLoader(data_test)
      # data_train = ImageFolder('data/lung/train' ,transforms.ToTensor(),) 
      # data_test = ImageFolder('data/lung/train' ) 
      
      # Split data into dict
      data_dict = dict()
      data_val = data_train
      data_dict = {'train': data_train, 'val': data_val, 'test': data_test}
      data_split_tuple = (data_dict.get('train'), data_dict.get('val'),
                        data_dict.get('test'))

      translator = BaseDataTranslator(config, client_cfgs) 
      fs_data = translator(data_train)
      return fs_data, config



def call_my_data(config, client_cfgs):
     if config.data.type == "lung224":
         data, modified_config = load_my_data(config, 224,client_cfgs)
         return data, modified_config
     elif config.data.type == "lung100":
         data, modified_config = load_my_data(config, 100,client_cfgs)
         return data, modified_config
     elif config.data.type == "lung384":
         data, modified_config = load_my_data(config, 384,client_cfgs)
         return data, modified_config
     elif config.data.type == "lung":
         data, modified_config = load_my_data(config, 100,client_cfgs)
         return data, modified_config
register_data("lung", call_my_data)


