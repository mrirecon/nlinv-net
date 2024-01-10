SBATCH_OPTIONS=" -p gpu-a100 -t 0-15:00:00 --ntasks=4 --gres=gpu:4"

SPLIT="0.75"
SPLIT_FLAG="2"

OS=1.5
COS=1.25
DATASET=03_t1_svd

NETWORK=" -i15 --resnet-block=no-batch-normalization,F=64 --iter-net=3 --alpha-min=0.001"
TRAINING="--lambda-sens=-0.001 --mask=msk -b16 -Te=250,dump-mod=50,r=0.001 -Texport-history=history --train-loss=mse=1.,mse-mean-dims=$(bart bitmask 15) -Tbatchgen-shuffle-data,average-loss --ss-ksp-split=$SPLIT --ss-ksp-split-shared=$SPLIT_FLAG"

export BART_GPU_STREAMS=4
MPIRUN="mpirun -n 2 --bind-to none "
