set -e

cd ../..

if [ ! -d "out" ];then
  mkdir out
fi


trainers="FedAvg  FedBN  fedem  FedOPT global local MedCal"

for alpha in 0.1 0.2 0.3 0.5 0.7 0.9
    do
        for trainer in $trainers

            do 
                echo " Trainer=${trainer}, data=${dataset}, alpha=${alpha}, starts..."
                python federatedscope/main.py --cfg scripts/my_configs/${trainer}_Lung_cancer.yaml   data.splitter_args "[{'alpha': ${lda_alpha}}]"     >>out/${trainer}_on_${lung}_alpha${alpha}.log 2>&1
                echo " Trainer=${trainer}, data=${dataset}, alpha=${alpha} ends."
            done
    done
