SBATCH_OPTIONS=" -p gpu-a100 -t 0-13:00:00 --ntasks=4 --gres=gpu:4"

SPOKES=13
SPLIT="0.75"
SPLIT_FLAG=2

OS=1.5
COS=1.25
DATASET=02_rt_rovir
TIME=3
ITER=3
ROVIR=" -V"

NETWORK="--scaling-flags=$(bart bitmask 10) --init-rtnlinv --conv-time=$TIME -i$((6+ITER)) --resnet-block=no-batch-normalization,F=64 --iter-net=$ITER"
TRAINING="--average-coils-loss=5 --lambda-sens=-0.001 --mask=msk -b16 -Te=10,dump-mod=1,r=0.001 -Texport-history=history --train-loss=mad=1.,mse-mean-dims=$(bart bitmask 15) -Tbatchgen-shuffle-data,average-loss --ss-ksp-split=$SPLIT --ss-ksp-split-shared=$SPLIT_FLAG"

export BART_GPU_STREAMS=4
MPIRUN="mpirun -n 4 --bind-to none "
