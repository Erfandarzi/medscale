set -e

cd ..

echo "Test distributed mode with LR..."

### server owns global test data
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_server.yaml &
### server doesn't own data
# python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_server_no_data.yaml &
sleep 2

# clients
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_client_1.yaml &
sleep 2
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_client_2.yaml &
sleep 2
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_client_3.yaml &

