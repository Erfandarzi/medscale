set -e

cd ../../..

DEVICE=$1
DEBUG=False

python medscale/main.py \
  --cfg medscale/nlp/hetero_tasks/baseline/config_isolated.yaml \
  --client_cfg medscale/nlp/hetero_tasks/baseline/config_client_isolated.yaml \
  outdir exp/isolated/ \
  device $DEVICE \
  data.is_debug $DEBUG \
