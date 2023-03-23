set -e

cd ..

echo "Run distributed mode with ConvNet-2 on FEMNIST..."

### server
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_femnist_server.yaml &
sleep 2

# clients
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_femnist_client_1.yaml &
sleep 2
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_femnist_client_2.yaml &
sleep 2
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_femnist_client_3.yaml &

