# Install a deep-learning-machine-environment on Ubuntu

## Dependencies Related
- [CUDA](https://developer.nvidia.com/cuda-10.1-download-archive-base): for accelerated computing 
- [anaconda](https://www.anaconda.com/products/individual): tool for environment management
- [jupyter lab](https://jupyter.org/)
- [git](https://product.hubspot.com/blog/git-and-github-tutorial-for-beginners)

 
### CUDA installation
You may want to see the detailed blog [here](https://www.pugetsystems.com/labs/hpc/How-to-install-CUDA-9-2-on-Ubuntu-18-04-1184/).   
Take CUDA 10.1 installation for example. 
1. Download the [CUDA 10.1 Ubuntu 18.04 source](https://developer.nvidia.com/cuda-10.1-download-archive-base?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=runfilelocal)  
2. `sudo sh cuda_10.1.105_418.39_linux.run`   
3. Set the path to `~/.bashrc`:
    ```
    # for cuda path
    cuda=cuda-10.1
    export PATH=/usr/local/$cuda/bin:$PATH
    export CUDADIR=/usr/local/$cuda
    export NUMBAPRO_NVVM=$CUDADIR/nvvm/lib64/libnvvm.so
    export NUMBAPRO_LIBDEVICE=$CUDADIR/nvvm/libdevice/
    export NVCCDIR=$CUDADIR/bin/nvcc
    export LD_LIBRARY_PATH=/usr/local/$cuda/lib64:$LD_LIBRARY_PATH
    export CPATH=/usr/local/$cuda/include:$CPATH
    export CUDA_HOME=/usr/local/$cuda
    # for CUDA_DEVICES
    export CUDA_DEVICE_ORDER=PCI_BUS_ID
    ```   

### Anaconda
Download the anaconda individual version from [Anaconda official website](https://www.anaconda.com/products/individual).   
1. Install: `bash Anaconda3-xxx-xxx.sh`, e.g., `bash Anaconda3-2020.07-Linux-x86_64.sh`. Suggest keeping the default settings.   
2. make sure to add anaconda path to `~/.bashrc`. If you forgot to do so, just add the below into bashrc:  
    ```
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/qiang/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/qiang/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/qiang/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/qiang/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    ```
    Note: Please change the `/home/qiang/anaconda3` to your own path to anaconda3.  

Here is how install a specific environment for one project. (deepgcn_env_install.sh, find this file [here](../scripts/deepgcn_env_install.sh)):  
    
    #!/usr/bin/env bash
    
    # make sure command is : source deepgcn_env_install.sh
    
    # uncomment if using cluster
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
        
Install the env above by: `source deepgcn_env_install.sh`. 
Now you install the new env called deepgcn, `conda activate deepgcn` and have fun!  
The official guide how to use anaconda is [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).  

### Jupyter Lab
[Jupyter lab](https://jupyter.org/): Jupyter exists to develop open-source software, open-standards, and services for interactive computing across dozens of programming languages. 
It's automatically installed when you install anaconda3.  You have to add conda env to jupyter lab manually by code below. 
    ```
    conda activate myenv
    python -m ipykernel install --user --name myenv --display-name "Python (myenv)"
    ```

Remote Support! 
Sometimes, we may need to run jupyter lab on our laptop but use the hardware and env of remote workstation. How to do that?
Open one terminal in your laptop, then open jupyter lab by code below
    ```
    ssh remoteAccount@eremoteIp # connect remote server
    # jupyter notebook password # uncomment if you have not set password (do it once)
    jupyter lab --port=9000 --no-browser &
    ```
Open another terminal in your laptop, then map ip by code below:
    ```
    ssh -N -f -L 8888:localhost:9000 remoteAccount@eremoteIp
    ```
You can kill the port forwarding by:
    ```
    ps aux | grep ssh
    kill <id>
    ```
Now open your chrome, type: `http://localhost:8888/`   
Enjoy your remote jupyter lab. 

More info see [blog](http://www.blopig.com/blog/2018/03/running-jupyter-notebook-on-a-remote-server-via-ssh/)


### Git Support (GitHub) 
Using `git` command to pull, push and manage your code. 
Here is [an introduction to git](https://product.hubspot.com/blog/git-and-github-tutorial-for-beginners).  
CheatSheet for `git` is [here](https://education.github.com/git-cheat-sheet-education.pdf).   

[GitHub](https://github.com/) is the largest code sharing, management and version control platform.  
You may have to add `ssh` to github, otherwise each time you use git command, you have to input your account information. Here is the [instruction](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).  

Set your git global username and email address. This is to let Git know who you are. (If you do not change this, you can still git pull and git push as along as you add your ssh into github. However, github will not be able to appreciate your commits in commit history, they will think it is someone else make the changes not you.) To set the username and email:  
`git config --global user.name "FIRST_NAME LAST_NAME"`  
`git config --global user.email "MY_NAME@example.com"`  



## Terminal Related 
- [Terminator](https://gnometerminator.blogspot.com/p/introduction.html): useful tool for arranging terminals  
- [Termius](https://termius.com/): SSH client that works on Desktop and Mobile for connecting to local and remote machines. 
- [tmux](https://linuxize.com/post/getting-started-with-tmux/): tools for multiple windows in terminal. Very useful for working with remote machines. 
The tmux will keep your job running in the background even if you lose you connection with the remote machines. 
[tmux cheatsheet](https://tmuxcheatsheet.com/).   
- vim: the best command line editor. [vim cheatsheet](https://vim.rtorr.com/)
- [rclone](https://rclone.org/install/): command tools for downloading and pushing files from or to google drive. 
[See here for more info](https://rclone.org/drive/).    
- [aria2](https://aria2.github.io/): a lightweight multi-protocol & multi-source command-line download utility.
Here is the [documentation](https://aria2.github.io/manual/en/html/aria2c.html#options). 
Here is an example (download imagenet using 16 threads and set the `continue=true` which resumes the downloading):  
`aria2c -c -x 16 -s 16 -d imagenet http://image-net.org/challenges/LSVRC/2012/dd31405981ef5f776aa17412e1f0c112/ILSVRC2012_img_train.tar`
- [Markdown](https://www.markdownguide.org/):  a lightweight markup language with plain-text-formatting syntax. 
[Markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)


## Software
- [PyCharm](https://www.jetbrains.com/pycharm/): my favorite IDE for Python. Professional version is free for students  
- [Clion](https://www.jetbrains.com/clion/): my favorite IDE for C and C++. Professional version is free for students  
- [MeshLab](https://snapcraft.io/install/meshlab/ubuntu): my favorite 3D viewer. 
- [Synergy](https://symless.com/synergy): share one mouse and keyboard between multiple computers (Linux, Mac, Windows). 


