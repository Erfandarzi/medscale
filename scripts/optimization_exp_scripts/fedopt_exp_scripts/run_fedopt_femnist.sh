set -e

cd ../..

echo "Run fedopt on femnist."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
=======
<<<<<<< HEAD
python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
=======
python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                                fedopt.use True \
                                federate.method FedOpt \
                                fedopt.optimizer.lr 1. \
