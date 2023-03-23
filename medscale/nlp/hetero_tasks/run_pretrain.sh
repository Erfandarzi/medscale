set -e

cd ../../..

DEVICE=$1
DEBUG=False

python medscale/main.py \
  --cfg medscale/nlp/hetero_tasks/baseline/config_pretrain.yaml \
  outdir exp/atc/pretrain/ \
  device $DEVICE \
  data.is_debug $DEBUG \
