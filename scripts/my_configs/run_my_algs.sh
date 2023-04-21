set -e

# cd ../..

if [ ! -d "out" ];then
  mkdir out
fi
#Exp1: 
#Table 1: Loss of training for each algorithm per round
#Table 2: f1 test acc final for each algorithm for alphas
# trainers="FedProx_vit FedProx FedAvg FedAvg_resnet FedBN global local"
trainers="local"
for lda_alpha in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
    do
        for trainer in $trainers
            do 
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha}, starts..."
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   data.splitter_args "[{'alpha': ${lda_alpha}}]"     >>out/${trainer}_on_lung_alpha${lda_alpha}.log 2>&1
=======
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   data.splitter_args "[{'alpha': ${lda_alpha}}]"     >>out/${trainer}_on_lung_alpha${lda_alpha}.log 2>&1
=======
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   data.splitter_args "[{'alpha': ${lda_alpha}}]"     >>out/${trainer}_on_lung_alpha${lda_alpha}.log 2>&1
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha} ends."
            done
    done

# trainers="FedProx_vit FedProx FedAvg FedAvg_resnet FedBN local"
trainers="local"

for sample_client_num in 2 3 4 5 6 7 8
    do
        for trainer in $trainers
            do 
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha}, starts..."
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   federate.sample_client_num ${sample_client_num}   >>out/${trainer}_on_lung_sample_client_num${sample_client_num}.log 2>&1
=======
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   federate.sample_client_num ${sample_client_num}   >>out/${trainer}_on_lung_sample_client_num${sample_client_num}.log 2>&1
=======
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   federate.sample_client_num ${sample_client_num}   >>out/${trainer}_on_lung_sample_client_num${sample_client_num}.log 2>&1
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha} ends."
            done
    done

#Exp2: Ablation personalization
#plot1 local_update_steps: regular_weight: 1,2,3,4
trainers="FedProx_vit"

alpha= "0.3"

for local_update_steps in 1 2 3 4 5 6 7
            do 
                echo " Trainer=${trainer}, data=${dataset},  local_update_steps =${local_update_steps}, starts..."
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml    personalization.local_update_steps ${local_update_steps}   >>out/${trainer}_on_lung_local_update_steps${local_update_steps}.log 2>&1
=======
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml    personalization.local_update_steps ${local_update_steps}   >>out/${trainer}_on_lung_local_update_steps${local_update_steps}.log 2>&1
=======
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml    personalization.local_update_steps ${local_update_steps}   >>out/${trainer}_on_lung_local_update_steps${local_update_steps}.log 2>&1
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                echo " Trainer=${trainer}, data=${dataset},  local_update_steps =${local_update_steps},   ends."
            done


#Exp2: Ablation personalization
#plot2 LR: 0.5 0.1 0.3 0.7
for learning_rate in 0.05 0.1 0.3 0.5 0.7
            do 
                echo " Trainer=${trainer}, data=${dataset}, learning_rate=${learning_rate}, starts..."
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   personalization.lr ${learning_rate}     >>out/${trainer}_on_lung_personalization_lr${learning_rate}.log 2>&1
=======
<<<<<<< HEAD
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   personalization.lr ${learning_rate}     >>out/${trainer}_on_lung_personalization_lr${learning_rate}.log 2>&1
=======
                python medscale/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   personalization.lr ${learning_rate}     >>out/${trainer}_on_lung_personalization_lr${learning_rate}.log 2>&1
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                echo " Trainer=${trainer}, data=${dataset}, learning_rate=${learning_rate} ends."
            done
