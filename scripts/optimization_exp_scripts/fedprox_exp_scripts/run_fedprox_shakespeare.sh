set -e

cd ../..

echo "Run fedprox on shakespeare."

python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lstm_on_shakespeare.yaml \
  fedprox.use True \
  fedprox.mu 0.1
