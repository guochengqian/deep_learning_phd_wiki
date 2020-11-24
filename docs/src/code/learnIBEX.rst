## How to use Ibex
### Termius
I would recomment a software called [termius](https://termius.com/) to all of you. This software keep you away from inputing account and password every time you want to login in the cluster.

You have to add host in termius. Add address, click ssh, add username and password once in termius, then you just need to click the host name then you can login into cluster(ibex). For example:
   
- address: glogin.ibex.kaust.edu.sa  
- username: qiang  
- password: xxxxxxxx  

After setting up, only a click is needed to ssh into the ibex system. 

### Apply for resources in cluster
You can either use sbatch or srun to run your program in cluster. 

1. sbatch
 
First option is using sbatch to send your job. 
Sbatch send your job in the priority queue and your code will continue to run even if you lose connection with cluster for some reason.

There is an example of sbatch file:
```
#!/bin/bash --login
#SBATCH -N 1
##SBATCH --array=1  # repeat the task
#SBATCH -J rloc
#SBATCH -o log/%x.%3a.%A.out    # make sure the log folder exists
#SBATCH -e log/%x.%3a.%A.err
#SBATCH --time=5-0:00:00
#SBATCH --gpus=8            # or: --gres=gpu:v100:8
#SBATCH --gpus-per-node=8   # use gpu_wide
#SBATCH --cpus-per-gpu=6
#SBATCH --mem-per-gpu=45G
#SBATCH --mail-user=xxx@kaust.edu.sa    # send message to your email
#SBATCH --mail-type=ALL
#SBATCH -A conf-gpu-2020.11.23
#SBATCH --constraint=[ref_32T]  # use shared folder in v100s.

# activate your conda env
echo "Loading anaconda..."

module purge
module load gcc
module load cuda/10.1.105
module load anaconda3
conda activate deepgcn

echo "...Anaconda env loaded"
python -u examples/classification/train.py  --phase train --train_path /scratch/dragon/intel/lig/guocheng/data/deepgcn/modelnet40
echo "...training function Done"
```

Run `sbatch train_ibex.sh` then your job will be put in the queue.   
You can check your queue info by : `squeue -u xxx(your account)`  
You can check the available GPUs by: `gpu-usage --nodes|grep v100`  


See [KAUST IBEX offical doc](https://www.hpc.kaust.edu.sa/sites/default/files/files/public/Cluster_training/26_11_2018/0_Ibex_cheat_sheet_Nov_26_2018.pdf) for detailed information. 
See the [IBEX Best Practice](../../../files/Deep%20Learning%20Best%20Practices.pdf) for the detailed configuration of best usage on IBEX. 

2. srun   
srun allow you to use cluster just like in terminal on your local machine. 
srun is convenient to use, however it will stop run when you lose connection with ibex. You need tmux to protect the node. 
When you lose connection, you can use tmux to login back into the node.  
There is a [tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058) 

You can srun into your allocated node using: `srun --jobid=yourjobid --time=00:25:00 --mem 48g --cpus-per-task=6 --pty bash`  
To do that, you have to use Sbatch at first to query for resources and start your training there. 
The srun is just used as a tube. After you srun into the node, you can check the memory usage of your GPUs.   

3. salloc
Please do NOT use salloc, only if you need all the GPUs in the node.
```
salloc --time=5-00:00:00 --cpus-per-task=8 --mem=32G --gres=gpu:4 --job-name=sr
```


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
rsync -vahP FilePath qiang@10.68.74.156:location
```
You can know your ip by `ifconfig`

If you want to scp many files, you can zip it at first. It's faster.  

### Skynet IP
If you are in Bernard's Group, you can use skynet (our own cluster), ip is 10.68.106.3.  
Login in by  `ssh youraccount@10.68.106.3`

