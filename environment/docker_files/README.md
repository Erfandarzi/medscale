

# Intro
We provide several docker files for easy environments set-up. 
<<<<<<< HEAD
The medscale images include all runtime stuffs with customized miniconda and required packages installed.
=======
The federatedscope images include all runtime stuffs with customized miniconda and required packages installed.
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737

The docker images are based on the nvidia-docker. 
Please pre-install the NVIDIA drivers and `nvidia-docker2` in the host machine, 
see details in https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

# Images
<<<<<<< HEAD
- `medscale-torch1.10.Dockerfile`: based on cuda:11.3 and ubuntu20.04, installed basic env with torch 1.10.1
- `medscale-torch1.10-application.Dockerfile`: based on cuda:11.3 and ubuntu20.04, installed torch 1.10.1, and down-stream applications such as graph and nlp
- `medscale-torch1.8-application.Dockerfile`: based on cuda:10.2 and ubuntu18.0, installed torch 1.8.0, used in the initial version development
- `medscale-jupyterhub`: based on cuda:11.3 and ubuntu20.04, installed torch 1.10.1, jupyter-singleuser for jupyterhub
=======
- `federatedscope-torch1.10.Dockerfile`: based on cuda:11.3 and ubuntu20.04, installed basic env with torch 1.10.1
- `federatedscope-torch1.10-application.Dockerfile`: based on cuda:11.3 and ubuntu20.04, installed torch 1.10.1, and down-stream applications such as graph and nlp
- `federatedscope-torch1.8-application.Dockerfile`: based on cuda:10.2 and ubuntu18.0, installed torch 1.8.0, used in the initial version development
- `federatedscope-jupyterhub`: based on cuda:11.3 and ubuntu20.04, installed torch 1.10.1, jupyter-singleuser for jupyterhub
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
