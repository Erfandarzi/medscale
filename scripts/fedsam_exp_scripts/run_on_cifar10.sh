set -e

algo=$1
alpha=$2
cudaid=$3

for (( i=0; i<5; i++ ))
do
<<<<<<< HEAD
  python medscale/main.py --cfg scripts/fedsam_exp_scripts/${algo}_on_cifar10.yaml seed $i device $cudaid data.splitter_args "[{'alpha': ${alpha}}]" expname ${algo}_${alpha}_${i}
=======
  python federatedscope/main.py --cfg scripts/fedsam_exp_scripts/${algo}_on_cifar10.yaml seed $i device $cudaid data.splitter_args "[{'alpha': ${alpha}}]" expname ${algo}_${alpha}_${i}
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
done
