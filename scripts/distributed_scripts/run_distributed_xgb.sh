set -e

cd ..

echo "Test distributed mode with XGB..."

### server
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_xgb_server.yaml &
sleep 2

# clients
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_xgb_client_1.yaml &
sleep 2
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_xgb_client_2.yaml &
<<<<<<< HEAD
=======
=======
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_xgb_server.yaml &
sleep 2

# clients
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_xgb_client_1.yaml &
sleep 2
python medscale/main.py --cfg scripts/distributed_scripts/distributed_configs/distributed_xgb_client_2.yaml &
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
sleep 2

