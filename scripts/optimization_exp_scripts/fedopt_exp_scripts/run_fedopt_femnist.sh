set -e

cd ../..

echo "Run fedopt on femnist."

python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
                                fedopt.use True \
                                federate.method FedOpt \
                                fedopt.optimizer.lr 1. \
