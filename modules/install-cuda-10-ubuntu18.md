# how to install cuda-10 on ubuntu 18.04

## Purge existign CUDA first / uninstall all cuda
```
sudo apt --purge remove "cublas*" "cuda*"
sudo apt --purge remove "nvidia*"
```

## install drivers
```
sudo ubuntu-drivers devices
sudo ubuntu-drivers autoinstall # automatically install the most compatible one
```
or simply run: 
```
sudo apt install nvidia-driver-418
```

## Install CUDA Toolkit 10

download: `https://developer.nvidia.com/cuda-10.0-download-archive`. download the local file.   
install cuda 10 according to this [blog](https://www.pugetsystems.com/labs/hpc/How-to-install-CUDA-9-2-on-Ubuntu-18-04-1184/)  
basically, you just need to install cuda-10.0 via `sh xxxcuda-10.0xxx.sh`. (choose not to install drivers, only cudatoolkit).   
Then add `cuda path` and `nvcc path` to `~/.bashrc` according to the blog.   
My `~/.bashrc` looks like this:  
```
export PATH=/usr/local/cuda-10.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
export CUDADIR=/usr/local/cuda-10.0
```
The way to install cuda-10.1 is the similar. 

# Normally. you do not have to install nvcc. Just need install it via Conda. (how? look `./deepgcn_env_install.sh`). 
<!--# Install CuDNN 7 and NCCL 2-->
<!--wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb-->
<!--sudo dpkg -i nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb-->

<!--sudo apt update-->
<!--sudo apt install -y libcudnn7 libcudnn7-dev libnccl2 libc-ares-dev-->

<!--sudo apt autoremove-->
<!--sudo apt upgrade-->

<!--# Link libraries to standard locations-->
<!--sudo mkdir -p /usr/local/cuda-10.0/nccl/lib-->
<!--sudo ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/nccl/lib/-->
<!--sudo ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.7 /usr/local/cuda-10.0/lib64/-->

<!--echo 'If everything worked fine, reboot now.'-->
