set -e

cd ../..

echo "Run fedopt on shakespeare."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lstm_on_shakespeare.yaml \
=======
<<<<<<< HEAD
python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lstm_on_shakespeare.yaml \
=======
python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lstm_on_shakespeare.yaml \
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
  fedopt.use True \
  federate.method FedOpt \
  fedopt.optimizer.lr 1.
