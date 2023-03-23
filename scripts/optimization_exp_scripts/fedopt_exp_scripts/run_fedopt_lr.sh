set -e

cd ../..

echo "Run fedopt on synthetic."

python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lr_on_synthetic.yaml \
  fedopt.use True \
  federate.method FedOpt \
  fedopt.optimizer.lr 1. \
