set -e

cd ..

echo "Run NbAFL on femnist."

<<<<<<< HEAD
python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
=======
<<<<<<< HEAD
python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
=======
python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                nbafl.use True \
                nbafl.mu 0.1 \
                nbafl.epsilon 20. \
                nbafl.constant 1. \
                nbafl.w_clip 0.1 \
                federate.join_in_info ['num_sample']