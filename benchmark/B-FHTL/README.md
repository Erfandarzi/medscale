# Benchmark for Federated Hetero-Task Learning

B-FHTL is a benchmark for federated hetero-task learning. 
It contains three federated datasets: Graph-DC, Graph-DT and Text-DT. 
Here we provide the datasets and scripts for the baselines.
More details about the benchmark please refer to [https://arxiv.org/abs/2206.03436](https://arxiv.org/abs/2206.03436)

**Notice**:
Considering medscale is an open-sourced library that updates frequently, to ensure the reproducibility of the experimental results, 
we create a new branch `feature/B-FHTL`. The users can reproduce the results by running the scripts under the directory [`scripts/B-FHTL_exp_scripts/`](https://github.com/alibaba/medscale/tree/feature/B-FHTL/scripts/B-FHTL_exp_scripts).  

## Baseline
We have built in some baselines in medscale, including federated optimization algorithms, federated personalization algorithms and federated meta learning algorithms.
Specifically, the baselines includes

 - Isolated
 - FedAvg
 - FedAvg+FT
 - FedProx
 - FedBn
 - FedBn+FT
 - Ditto
 - FedMAML

## Dataset 
### Graph-DC
The dataset Graph-DC is consisted of 13 graph classification tasks. Each task represents a client in federated learning, and hold different learning goals. You can choose this dataset by setting `data.type` as `fs_contest_data`.

### Graph-DT
The dataset Graph-DT is consisted of 16 graph tasks, including 10 binary classification tasks, 6 regression tasks. You can choose this dataset by setting `data.type` as `graph-dt`.

### Text-DT
The dataset Text-DT is consisted of 3 NLP tasks, including sentiment classification, reading compression and sentence pair similarity prediction. 
You can choose this dataset by setting `data.type` as `text-dt`.

## Quick Start
 
You can find the configurations of the baselines under the directory [`scripts/B-FHTL_exp_scripts/${DATA_NAME}/`](https://github.com/alibaba/medscale/tree/feature/B-FHTL/scripts/B-FHTL_exp_scripts), where `DATA_NAME` is the name of the dataset (Graph-DC, Graph-DT or Text-DT).  
We also provide high performance operation (hpo) scripts to search for the best hyper-parameters, you can refer to `scripts/B-FHTL_exp_scripts/${DATA_NAME}/hpo`.

To run the script, you should 
- First clone the repository [medscale](https://github.com/alibaba/medscale),
- Then follow [README.md](https://github.com/alibaba/medscale/blob/master/README.md) to build the running environment for medscale, 
- Install the `learn2learn` and `transformers` packages that are required by benchmark, 
- Switch to the branch `feature/B-FHTL` and run the scripts
```bash
# Step-1. clone the repository 
git clone https://github.com/alibaba/medscale.git

# Step-2. follow https://github.com/alibaba/medscale/blob/master/README.md to build the running environment

# Step-3. install packages required by the benchmark
pip install learn2learn transformers

# Step-3. switch to the branch `feature/B-FHTL` for the benchmark
git switch feature/B-FHTL

# Step-4. run the baseline (taking fedavg with Graph-DC as an example)
cd medscale
<<<<<<< HEAD
python medscale/main.py --cfg scripts/B-FHTL_exp_scripts/Graph-DC/fedavg.yaml
=======
<<<<<<< HEAD
python medscale/main.py --cfg scripts/B-FHTL_exp_scripts/Graph-DC/fedavg.yaml
=======
python medscale/main.py --cfg scripts/B-FHTL_exp_scripts/Graph-DC/fedavg.yaml
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f

# If you want to run the hpo scripts
cd scripts/B-FHTL_exp_scripts/Graph-DC/hpo
bash run_fedavg_ft.sh 0 ./data
```