set -e

cd ..

echo "Run hfl-sgdmf task on movielens1m."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/mf/baseline/hfl-sgdmf_fedavg_standalone_on_movielens1m.yaml \
=======
<<<<<<< HEAD
python medscale/main.py --cfg medscale/mf/baseline/hfl-sgdmf_fedavg_standalone_on_movielens1m.yaml \
=======
python medscale/main.py --cfg medscale/mf/baseline/hfl-sgdmf_fedavg_standalone_on_movielens1m.yaml \
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
          sgdmf.use True \
          sgdmf.epsilon 0.5 \
          sgdmf.delta 0.5 \
          train.optimizer.lr 0.1 \
          train.local_update_steps 20 \
          federate.total_round_num 50 \
          dataloader.batch_size 64
