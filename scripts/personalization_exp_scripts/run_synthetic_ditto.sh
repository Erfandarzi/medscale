set -e

cd ../..

cudaid=$1
dataset=synthetic

echo "HPO starts..."

models=('lr')
lrs=(0.5 0.01 0.1 0.05 0.005)
local_updates=(10 30)
personalization_regular_weight=0.1
method=Ditto
bs=64
outdir=exp_out/${method}

for (( g=0; g<${#models[@]}; g++ ))
do
    for (( i=0; i<${#lrs[@]}; i++ ))
    do
        for (( j=0; j<${#local_updates[@]}; j++ ))
        do
            for k in {1..3}
            do
<<<<<<< HEAD
                python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lr_on_synthetic.yaml federate.method ${method} dataloader.batch_size ${bs} personalization.regular_weight ${personalization_regular_weight} device ${cudaid} train.optimizer.lr ${lrs[$i]} train.local_update_steps ${local_updates[$j]} model.type ${models[$g]} seed $k outdir ${outdir}/${models[$g]}_${lrs[$i]}_${local_updates[$j]}_bs${bs}_on_${dataset}
=======
<<<<<<< HEAD
                python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lr_on_synthetic.yaml federate.method ${method} dataloader.batch_size ${bs} personalization.regular_weight ${personalization_regular_weight} device ${cudaid} train.optimizer.lr ${lrs[$i]} train.local_update_steps ${local_updates[$j]} model.type ${models[$g]} seed $k outdir ${outdir}/${models[$g]}_${lrs[$i]}_${local_updates[$j]}_bs${bs}_on_${dataset}
=======
                python medscale/main.py --cfg medscale/nlp/baseline/fedavg_lr_on_synthetic.yaml federate.method ${method} dataloader.batch_size ${bs} personalization.regular_weight ${personalization_regular_weight} device ${cudaid} train.optimizer.lr ${lrs[$i]} train.local_update_steps ${local_updates[$j]} model.type ${models[$g]} seed $k outdir ${outdir}/${models[$g]}_${lrs[$i]}_${local_updates[$j]}_bs${bs}_on_${dataset}
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
            done
        done
    done
done

echo "HPO ends."
