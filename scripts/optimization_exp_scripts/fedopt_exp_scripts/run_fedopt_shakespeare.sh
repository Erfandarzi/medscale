set -e

cd ../..

echo "Run fedopt on shakespeare."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lstm_on_shakespeare.yaml \
=======
python federatedscope/main.py --cfg federatedscope/nlp/baseline/fedavg_lstm_on_shakespeare.yaml \
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
  fedopt.use True \
  federate.method FedOpt \
  fedopt.optimizer.lr 1.
