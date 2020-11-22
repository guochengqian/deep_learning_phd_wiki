#!/bin/bash --login
#SBATCH -o slurm_logs/%x.%3a.%A.out
#SBATCH -e slurm_logs/%x.%3a.%A.err
#SBATCH --time=0:30:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-gpu=6
#SBATCH --mem-per-gpu=45G#SBATCH --mail-type=FAIL,TIME_LIMIT,TIME_LIMIT_90
#SBATCH --mail-user=guocheng.qian@kaust.edu.sa
##SBATCH -A conf-gpu-2020.11.23

set -ex

hostname
nvidia-smi
env

echo "##########################################"

conda activate deepgcn
module load cuda/10.0.130
module load gcc

# test model from CHECKPOINT
python test.py \
--data_dir $DATA_DIR \
--block $BLOCK \
--conv $CONV \
--n_blocks $N_BLOCKS \
--n_filters $N_FILTERS \
--norm $NORM \
--batch_size 16 \
--pretrained_model $PRETRAIN

