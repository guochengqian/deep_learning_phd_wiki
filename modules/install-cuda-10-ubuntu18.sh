#!/bin/bash

# Purge existign CUDA first / uninstall all cuda
sudo apt --purge remove "cublas*" "cuda*"
sudo apt --purge remove "nvidia*"

# install drivers
sudo ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

# Install CUDA Toolkit 10
download: https://developer.nvidia.com/cuda-10.0-download-archive
install cuda 10 according to : https://www.pugetsystems.com/labs/hpc/How-to-install-CUDA-9-2-on-Ubuntu-18-04-1184/

#wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
#sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub && sudo apt update
#sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb

#sudo apt update
#sudo apt install -y cuda

# Install CuDNN 7 and NCCL 2
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo dpkg -i nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb

sudo apt update
sudo apt install -y libcudnn7 libcudnn7-dev libnccl2 libc-ares-dev

sudo apt autoremove
sudo apt upgrade

# Link libraries to standard locations
sudo mkdir -p /usr/local/cuda-10.0/nccl/lib
sudo ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/nccl/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.7 /usr/local/cuda-10.0/lib64/

echo 'If everything worked fine, reboot now.'
