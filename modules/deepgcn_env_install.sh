#!/usr/bin/env bash
# make sure command is : source deepgcn_env_install.sh

# uncomment to install anaconda3.
#cd ~/
#wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
#bash Anaconda3-2019.07-Linux-x86_64.sh

# uncommet if using cluster
# module purge
# module load gcc
# module load cuda/10.1.105

# make sure your annaconda3 is added to bashrc (normally add to bashrc path automatically)
source ~/.bashrc

conda create -n deepgcn # conda create env
conda activate deepgcn  # activate

# conda install and pip install
conda install -y pytorch torchvision cudatoolkit=10.0 tensorflow python=3.7 -c pytorch
# install useful modules
pip install tqdm
