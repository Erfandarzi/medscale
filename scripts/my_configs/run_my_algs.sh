set -e

# cd ../..

if [ ! -d "out" ];then
  mkdir out
fi
#Exp1: 
#Table 1: Loss of training for each algorithm per round
#Table 2: f1 test acc final for each algorithm for alphas
trainers="local MedCal"

for lda_alpha in 0.1 
    do
        for trainer in $trainers

            do 
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha}, starts..."
                python federatedscope/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   data.splitter_args "[{'alpha': ${lda_alpha}}]"     >>out/${trainer}_on_lung_alpha${lda_alpha}.log 2>&1
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha} ends."
            done
    done

#Exp1: 
#Table 1: Loss of training for each algorithm per round
#Table 2: f1 test acc final for each algorithm for alphas
trainers="FedAvg FedAvg_resnet FedBN  fedem  FedOPT global local MedCal"

for lda_alpha in 0.2 0.3 0.5 0.7 0.9
    do
        for trainer in $trainers

            do 
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha}, starts..."
                python federatedscope/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   data.splitter_args "[{'alpha': ${lda_alpha}}]"     >>out/${trainer}_on_lung_alpha${lda_alpha}.log 2>&1
                echo " Trainer=${trainer}, data=${dataset}, alpha=${lda_alpha} ends."
            done
    done


#Exp2: Ablation personalization
#plot1 local_update_steps: regular_weight: 1,2,3,4
trainer="MedCal"

alpha= 0.3

for local_update_steps in 1 2 3 4
            do 
                echo " Trainer=${trainer}, data=${dataset},  local_update_steps =${local_update_steps}, starts..."
                python federatedscope/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml    personalization.local_update_steps ${local_update_steps}   >>out/${trainer}_on_lung_local_update_steps${local_update_steps}.log 2>&1
                echo " Trainer=${trainer}, data=${dataset},  local_update_steps =${local_update_steps},   ends."
            done


#Exp2: Ablation personalization
#plot2 LR: 0.5 0.1 0.3 0.7
for learning_rate in 0.5 0.1 0.3 0.7
            do 
                echo " Trainer=${trainer}, data=${dataset}, learning_rate=${learning_rate}, starts..."
                python federatedscope/main.py --cfg scripts/my_configs/MedCal_Lung_cancer.yaml   personalization.lr ${learning_rate}     >>out/${trainer}_on_lung_personalization_lr${learning_rate}.log 2>&1
                echo " Trainer=${trainer}, data=${dataset}, learning_rate=${learning_rate} ends."
            done
