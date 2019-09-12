# HandBook for Deep Learning
## Anaconda and Environment
Anaconda3 is a very useful tool to manage environment. I usually install a new env for each different project. Like, when I worked on deep gcn, I created an anaconda3 env called deepgcn. Everytime I wanted to run code of this project, I just had to `conda activate deepgcn` to activate the env. 

### How to use conda
See the [doc](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) here for detailed information.   
Here is example how to install anaconda3 and pytorch env and use them.


deepgcn_env_install.sh:
```
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
```
Install the env above by: `source deepgcn_env_install.sh`


### Install CUDA and GPU Driver


## How to use Pytorch
For beginners, there are official [tutorials](https://pytorch.org/tutorials/) and [60min exercise](https://pytorch.org/tutorials/beginner/deep_learning_60min_blitz.html) you can try at first. It's quite beginer-friendly and easy to follow.

To improve futher, I would recommend see other's code. I recommend serval repos in good structure and easy to understand and implement.
[CycleGAN](https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix) by Jun-yan Zhu.
[deep_gcn_pytorch](https://github.com/lightaime/deep_gcns_torch) by me and Guohao Li.

You need to refer to the [official document](https://pytorch.org/docs/stable/index.html) and stackoverflow sometimes. Don't hesitate to ask questions in the github repos when you need help.


# How to use Ibex
1. termius setup.   
address:vlogin.ibex.kaust.edu.sa  
username: qiang  
password: Kaustxxxx  
   
2. open a terminal   
```
tmux new -s job1 
srun --time=5-00:00:00 --cpus-per-task=4 --mem=10G --gres=gpu:1 --job-name=gsr8 --pty bash

module purge
module load anaconda3
module load gcc
module load cuda/10.1.105
conda activate pointsr 
sh ./script/xx.sh
```

or using sbatch
see [this](https://www.hpc.kaust.edu.sa/sites/default/files/files/public/Cluster_training/26_11_2018/0_Ibex_cheat_sheet_Nov_26_2018.pdf).

3. datasets   
/ibex/scratch/qiang

4. scp file  
scp -r afolder qiang@10.68.74.156:/location  
scp afile qiang@10.68.74.156:/location  

remember never scp too many files. zip it at first.   

5. skynet  
ssh qiang@10.68.106.3

# About env installation
1. install software.  
Terminator  
Termius  
Pycharm  
Synergy  
Xnview  
Filezilla   
conda  
matlab  
chrome  
mailspring  
slack  

2. install env  
show envs: conda info -e

sudo apt-get install nvidia-XYXYX   
Check for cuda: nvcc --version  

conda env:
```
conda create --name pytorch04
conda activate pytorch04
conda install pytorch=0.4.1 cuda90 torchvision tensorflow -c pytorch 
pip install opencv-python scipy scikit-image
```

<!-- tesorflow for 3d -->
pip install --upgrade tensorflow-graphics  
pip install opencv-python  
caffe:  
make sure all from defaults channel  
conda list --show-channel-urls  

conda create -n caffe_gpu -c defaults python=2.7 caffe-gpu    


module list  
module avail  
module load cudnn  

*always use conda install if applicable. conda install tensorflow, instead of pip install*
3. conda envs to jupyter lab
source activate myenv
python -m ipykernel install --user --name myenv --display-name "Python (myenv)"

# Debug
1. tensor 2 CV IMAGE 
```
from TorchTools.DataTools.FileTools import _tensor2cvimage 
import numpy as np 
import cv2 
img_output = _tensor2cvimage(img[0], np.uint8) 
cv2.imwrite('/data/debug/img.png', img_output)  
```

2. model parameters  
model.SFE1.nn._modules['0'].weight

# Linux 
1. counting  
ls -l | wc -l
2. download  
wget -r -p -np -k  
3. count storage usage  
du --max-depth=1 -h
4. show modified time  
stat -c '%y : %n' ./*  
5. watch gpu usage  
watch -n 0.1 nvidia-smi

  
# Vim
1. vim top of file
    command mode: gg  
    vim end of file: ga
    
    
# How to design architecture 
1. always remember to keep the changeble part as a new name. So we can
easily load pretrained even if they are in different shape  


# pycharm cheatsheet
