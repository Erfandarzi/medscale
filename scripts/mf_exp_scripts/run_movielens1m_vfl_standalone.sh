set -e

cd ..

echo "Run MF task on movielens1m."

python medscale/main.py --cfg medscale/mf/baseline/vfl_fedavg_standalone_on_movielens1m.yaml \
      sgdmf.use False \
      train.optimizer.lr 0.8 \
      train.local_update_steps 20 \
      federate.total_round_num 50 \
      dataloader.batch_size 32