<<<<<<< HEAD
cd ../medscale/medscale/
=======
<<<<<<< HEAD
cd ../medscale/medscale/
=======
cd ../medscale/medscale/
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f

python main.py --cfg contrib/configs/config_maml.yaml --cfg_client contrib/configs/config_client_maml.yaml outdir exp/sts_imdb_squad/maml/

python main.py --cfg contrib/configs/config_ft.yaml --cfg_client contrib/configs/config_client_maml_ft.yaml outdir exp/sts_imdb_squad/maml/ federate.method maml federate.load_from exp/sts_imdb_squad/maml/ckpt/
