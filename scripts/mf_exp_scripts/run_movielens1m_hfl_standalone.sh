set -e

cd ..

echo "Run MF task on movielens1m."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/mf/baseline/hfl_fedavg_standalone_on_movielens1m.yaml \
=======
python federatedscope/main.py --cfg federatedscope/mf/baseline/hfl_fedavg_standalone_on_movielens1m.yaml \
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
      sgdmf.use False \
      train.optimizer.lr 0.8 \
      train.local_update_steps 20 \
      federate.total_round_num 50 \
      dataloader.batch_size 32
