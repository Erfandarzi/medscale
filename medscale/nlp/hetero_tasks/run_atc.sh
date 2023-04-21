set -e

cd ../../..

DEVICE=$1
DEBUG=False

python medscale/main.py \
  --cfg medscale/nlp/hetero_tasks/baseline/config_atc.yaml \
  --client_cfg medscale/nlp/hetero_tasks/baseline/config_client_atc.yaml \
  federate.atc_load_from exp/atc/pretrain/ckpt/ \
  outdir exp/atc/train/ \
  device $DEVICE \
  data.is_debug $DEBUG \
