set -e

cd ..

echo "Run vfl-sgdmf task on movielens1m."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/mf/baseline/vfl-sgdmf_fedavg_standalone_on_movielens1m.yaml \
=======
python federatedscope/main.py --cfg federatedscope/mf/baseline/vfl-sgdmf_fedavg_standalone_on_movielens1m.yaml \
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
          sgdmf.use True \
          sgdmf.epsilon 0.5 \
          sgdmf.delta 0.5 \
          train.optimizer.lr 0.1 \
          train.local_update_steps 20 \
          federate.total_round_num 50 \
          dataloader.batch_size 64
