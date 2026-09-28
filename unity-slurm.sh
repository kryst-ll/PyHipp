#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "unity-early"
#SBATCH -o unity-early-slurm.%N.%j.out
#SBATCH -e unity-early-slurm.%N.%j.err
python -u -c "import PyHipp as pyh; pyh.Unity(saveLevel=1);"
