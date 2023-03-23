set -e

cd ../../..

DEVICE=$1
DEBUG=False

python medscale/main.py \
  --cfg medscale/nlp/hetero_tasks/baseline/config_fedavg.yaml \
  --client_cfg medscale/nlp/hetero_tasks/baseline/config_client_fedavg.yaml \
  outdir exp/fedavg/ \
  device $DEVICE \
  data.is_debug $DEBUG \
