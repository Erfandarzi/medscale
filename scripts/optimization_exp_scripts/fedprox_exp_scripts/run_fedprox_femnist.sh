set -e

cd ../..

echo "Run fedprox on femnist."

python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml \
  fedprox.use True \
  fedprox.mu 0.1
