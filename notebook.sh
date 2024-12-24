#!/bin/bash
#SBATCH -c 2 # request two cores 
#SBATCH -o /netscratch/duynguyen/Research/duo-attention/logs/jupyter.out
#SBATCH -e /netscratch/duynguyen/Research/duo-attention/logs/jupyter_error.out
#SBATCH -p A100-IML 
#SBATCH --mem-per-cpu 32G
#SBATCH --time=1-00:00
#SBATCH --job-name=notebook
#SBATCH --ntasks 1
#SBATCH --gpus-per-task=1 



jupyter-notebook --no-browser --ip=0.0.0.0 --port 8888