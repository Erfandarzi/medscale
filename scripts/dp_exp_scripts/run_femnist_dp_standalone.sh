set -e

cd ..

echo "Run NbAFL on femnist."

python medscale/main.py --cfg medscale/cv/baseline/fedavg_convnet2_on_femnist.yaml\
                nbafl.use True \
                nbafl.mu 0.1 \
                nbafl.epsilon 20. \
                nbafl.constant 1. \
                nbafl.w_clip 0.1 \
                federate.join_in_info ['num_sample']