<<<<<<< HEAD
cd ../FederatedScope/medscale/
=======
cd ../FederatedScope/federatedscope/
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737

python main.py --cfg contrib/configs/config_ft.yaml --cfg_client contrib/configs/config_client_fedavg_ft.yaml outdir exp/sts_imdb_squad/fedavg_ft/ federate.method fedavg federate.load_from exp/sts_imdb_squad/fedavg/ckpt/
