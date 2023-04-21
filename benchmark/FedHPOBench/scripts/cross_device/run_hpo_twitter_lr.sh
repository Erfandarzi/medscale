set -e

cudaid=$1
dataset=$2
lr=$3

# lrs=(0.00001 0.0001 0.001 0.01 0.1 1.0)

cd ../../../..

out_dir=out_${dataset} 

if [ ! -d $out_dir ];then
  mkdir $out_dir
fi

echo "HPO starts..."

sample_rates=(0.01)
wds=(0.0 0.001 0.01 0.1)
steps=(1 2 3 4)
batch_sizes=(64)

for (( sr=0; sr<${#sample_rates[@]}; sr++ ))
do
    for (( w=0; w<${#wds[@]}; w++ ))
    do
        for (( s=0; s<${#steps[@]}; s++ ))
        do
            for (( b=0; b<${#batch_sizes[@]}; b++ ))
            do
                for k in {1..3}
                do
<<<<<<< HEAD
                    python medscale/main.py --cfg benchmark/FedHPOBench/scripts/lr/twitter.yaml device $cudaid train.optimizer.lr $lr train.optimizer.weight_decay ${wds[$w]} train.local_update_steps ${steps[$s]} data.batch_size ${batch_sizes[$b]} federate.sample_client_rate ${sample_rates[$sr]} seed $k outdir lr/${out_dir}_${sample_rates[$sr]} expname lr${lr}_wd${wds[$w]}_dropout0_step${steps[$s]}_batch${batch_sizes[$b]}_seed${k}
=======
<<<<<<< HEAD
                    python medscale/main.py --cfg benchmark/FedHPOBench/scripts/lr/twitter.yaml device $cudaid train.optimizer.lr $lr train.optimizer.weight_decay ${wds[$w]} train.local_update_steps ${steps[$s]} data.batch_size ${batch_sizes[$b]} federate.sample_client_rate ${sample_rates[$sr]} seed $k outdir lr/${out_dir}_${sample_rates[$sr]} expname lr${lr}_wd${wds[$w]}_dropout0_step${steps[$s]}_batch${batch_sizes[$b]}_seed${k}
=======
                    python medscale/main.py --cfg benchmark/FedHPOBench/scripts/lr/twitter.yaml device $cudaid train.optimizer.lr $lr train.optimizer.weight_decay ${wds[$w]} train.local_update_steps ${steps[$s]} data.batch_size ${batch_sizes[$b]} federate.sample_client_rate ${sample_rates[$sr]} seed $k outdir lr/${out_dir}_${sample_rates[$sr]} expname lr${lr}_wd${wds[$w]}_dropout0_step${steps[$s]}_batch${batch_sizes[$b]}_seed${k}
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
                done
            done
        done
    done
done

echo "HPO ends."
