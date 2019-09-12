# HandBook for Deep Learning
## Content
1. [How to install environment](#anaconda-and-environment)  
1. [How to use Pytorch](#how-to-use-pytorch)
1. [How to use Ibex](#how-to-use-ibex)  
1. [Useful Cheatsheet](#some-useful-codes)  

## Anaconda and Environment
Anaconda3 is a very useful tool to manage environment. I usually install a new env for each different project. Like, when I worked on deep gcn, I created an anaconda3 env called deepgcn. Everytime I wanted to run code of this project, I just had to `conda activate deepgcn` to activate the env. 

### How to use conda
Here is example how to install anaconda3 and pytorch env and use them.


deepgcn_env_install.sh(find this file in `modules/`):
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
Install the env above by: `source deepgcn_env_install.sh`. 
Now you install the new env called deepgcn, `conda activate deepgcn` and have fun!

If you want to improve you knowledge about anaconda, see the [doc](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) here for detailed information. 

### Install CUDA and GPU Driver
There is a bash script helps you install CUDA10, cudnn and driver on unbuntu18.04 easily. 
Find the script `modules/install-cuda-10-ubuntu18.sh`
All you need to do is `source modules/install-cuda-10-ubuntu18.sh`.


### Jupyter Lab
Jupyter lab is a very useful web-based user interface for project. It's automaticall installed when you install ananconda3. 
You have to add conda env to jupyter lab manually by code below. 
```
conda activate myenv
python -m ipykernel install --user --name myenv --display-name "Python (myenv)"
```

## How to use Pytorch
For beginners, there are official [tutorials](https://pytorch.org/tutorials/) and [60min exercise](https://pytorch.org/tutorials/beginner/deep_learning_60min_blitz.html) you can try at first. It's quite beginer-friendly and easy to follow.
Also, you can try some easy and funny experiments:
- [train a classifier](https://pytorch.org/tutorials/beginner/blitz/cifar10_tutorial.html#sphx-glr-beginner-blitz-cifar10-tutorial-py)
- [train an image style transformer](https://github.com/leongatys/PytorchNeuralStyleTransfer/blob/master/NeuralStyleTransfer.ipynb)


To improve futher, I would recommend go through other's code. I recommend serval repos in good structure and easy to understand and implement.
- [CycleGAN](https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix) by [Jun-yan Zhu](https://people.csail.mit.edu/junyanz/).
- [deep_gcn_pytorch](https://github.com/lightaime/deep_gcns_torch) by me and [Guohao Li](https://github.com/lightaime).
- You need to refer to the [official document](https://pytorch.org/docs/stable/index.html) and stackoverflow sometimes.

 Don't hesitate to ask questions in all the github repos when you need help.


## How to use Ibex
### Termius
I would recomment a software called [termius](https://termius.com/) to all of you. This software keep you away from inputing account and password every time you want to login in the cluster.

You have to add host in termius. Add address, click ssh, add username and password once in termius, then you just need to click the host name then you can login into cluster(ibex). For example:
   
- address:vlogin.ibex.kaust.edu.sa  
- username: qiang  
- password: Kaustxxxx  

### Apply for resources in cluster
You can either use sbatch or srun to run your program in cluster. 

1. sbatch
 
First option is using sbatch to send your job. 
Sbatch send your job in the priority squeue and your code will contiue to run even if your connection with cluster is closed for some reason.

There is an example of sbatch file. (find the file in `modules/train_ibex.sh`):
```
#!/bin/bash
#SBATCH -J dg_cls
#SBATCH -o %x.%3a.%A.out
#SBATCH -e %x.%3a.%A.err
#SBATCH --time=9-0:00:00
#SBATCH --gres=gpu:v100:1
#SBATCH --cpus-per-task=9
#SBATCH --mem=32G
#SBATCH --qos=ivul
#SBATCH --mail-user=guocheng.qian@kaust.edu.sa
#SBATCH --mail-type=ALL

# activate your conda env
echo "Loading anaconda..."

module purge
module load gcc
module load cuda/10.1.105
module load anaconda3
source ~/.bashrc
source activate deepgcn

echo "...Anaconda env loaded"
python -u examples/classification/train.py  --phase train --train_path /scratch/dragon/intel/lig/guocheng/data/deepgcn/modelnet40
echo "...training function Done"
```

Run `sbatch train_ibex.sh` then your job will be put in the squeue. 

See [KAUST IBEX offical doc](https://www.hpc.kaust.edu.sa/sites/default/files/files/public/Cluster_training/26_11_2018/0_Ibex_cheat_sheet_Nov_26_2018.pdf) for detailed information. 


2. srun   
srun allow you to use cluster just like in terminal on your local machine. 

srun is convenient to use however it will stop run when you loss connection to ibex. You need tmux to protect the node. When you lose connection, you can use tmux to login back into the node. 

```
tmux new -s job1 
srun --time=5-00:00:00 --cpus-per-task=4 --mem=10G --gres=gpu:1 --job-name=gsr8 --pty bash
```
There is a [tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058) 

### Load or purge modules
- use `module list` to see your current modules
- use `module avail` to see all the modules available in cluster
- use `module purge` to unload all the modules you loaded
- use `module unload xxx` to unload a module 
- use `module load xxx` to load the module you want


###  Data Localtion 
Put your data in this folder `/ibex/scratch/$YOUR ACCOUNT$`. IO in this folder is faster than other location.

### File Transfer
Termius allows you to transfer files by GUI.
You can also transfer files by scp. 
```  
scp -r FolderPath YourAccount@YourIP:/location  # scp a folder
scp FilePath YourAccount@YourIP:/location  # scp a file
```
You can know your ip by `ifconfig`

If you want to scp many files, you can zip it at first. It's faster.  

### Skynet IP
If you are in Bernard's Group, you can use skynet (our own cluster), ip is 10.68.106.3.  
Login in by  `ssh youraccount@10.68.106.3`


## Some useful codes
<!--
### Debug
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

-->
### Linux 
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

  
### Vim
vim top of file :gg  
vim end of file: GA (remember CAPS)  
[Vim cheatsheet](https://vim.rtorr.com/)

### MarkDown
[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

### Tmux
[Tmux Cheatsheet](https://gist.github.com/MohamedAlaa/2961058)
    
### Pycharm
[Pycharm Cheatsheet](https://www.jetbrains.com/help/pycharm/mastering-keyboard-shortcuts.html)


### jupter lab
[JupyterLab Cheatsheet](https://blog.ja-ke.tech/2019/01/20/jupyterlab-shortcuts.html)

