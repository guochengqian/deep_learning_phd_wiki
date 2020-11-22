#!/bin/bash

##########################################
########## PARAMS TO SEARCH FOR ##########
##########################################
CURRENT_EPOCH=-1
PRETRAIN=''
OUTPUT_DIR='log'
##########################################
########## PARAMS TO KEEP AS IS ##########
##########################################
NUM_GPUS=4
EXP_NAME=sem_seg_dense

# model parameters
BLOCK=res
CONV=edge
N_BLOCKS=7
N_FILTERS=64
NORM=None

# training params
BATCH_SIZE=$((8*${NUM_GPUS}))
LR=$(echo "0.0005*$NUM_GPUS" | bc -l )
EPOCHS=100
MAX_EPOCHS=100
# data and annotations
DATA_DIR=/ibex/scratch/qiang/data/deepgcn/S3DIS


##########################################
## Generate other params from the given ##
##########################################
EXP_NAME=${EXP_NAME}-${BLOCK}-${CONV}-n${N_BLOCKS}-C${N_FILTERS}-norm_${NORM}-LR${LR}-B${BATCH_SIZE}
JOB_NAME=$EXP_NAME-$(date "+%Y%m%d-%H%M%S")-$(uuidgen)
echo $JOB_NAME

##########################################
## Call Sbatch file ##
##########################################
mkdir -p slurm_logs
sbatch --gres=gpu:v100:$NUM_GPUS --job-name=${EXP_NAME}-T${CURRENT_EPOCH} \
--export=ALL,CURRENT_EPOCH=$CURRENT_EPOCH,PRETRAIN=$PRETRAIN,OUTPUT_DIR=$OUTPUT_DIR,NUM_GPUS=$NUM_GPUS,BLOCK=$BLOCK,CONV=$CONV,N_BLOCKS=$N_BLOCKS,N_FILTERS=$N_FILTERS,NORM=$NORM,BATCH_SIZE=$BATCH_SIZE,LR=$LR,EPOCHS=$EPOCHS,MAX_EPOCHS=$MAX_EPOCHS,DATA_DIR=$DATA_DIR,EXP_NAME=$EXP_NAME,JOB_NAME=$JOB_NAME \
slurm_train_n_epochs.sh


