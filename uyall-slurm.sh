#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "uyall-early"
#SBATCH -o uyall-early-slurm.%N.%j.out
#SBATCH -e uyall-early-slurm.%N.%j.err
python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import glob; \
days = [d for d in sorted(glob.glob('[0-9]'*8)) if d < '20180701']; \
dirs = [s for d in days for s in sorted(glob.glob(d + '/session*'))]; \
uyall = DPT.objects.processDirs(dirs=dirs, exclude=['*eye*','*mountains*'], objtype=pyh.Unity, saveLevel=1); \
uyall.save(); \
import pickle; \
f = open('uyallTimePerformance.pkl', 'wb'); \
pickle.dump(uyall.timePerformance, f); \
f.close()" && aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:549596002800:awsnotify --message "UnityEarlyJobDone"
