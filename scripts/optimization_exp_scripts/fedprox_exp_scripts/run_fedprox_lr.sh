set -e

cd ../..

echo "Run fedopt on synthetic."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lr_on_synthetic.yaml \
=======
python federatedscope/main.py --cfg federatedscope/nlp/baseline/fedavg_lr_on_synthetic.yaml \
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
  fedprox.use True \
  fedprox.mu 0.1
