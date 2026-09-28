#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "udall-early"
#SBATCH -o udall-early-slurm.%N.%j.out
#SBATCH -e udall-early-slurm.%N.%j.err
python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import glob; \
days = [d for d in sorted(glob.glob('[0-9]'*8)) if d < '20180701']; \
udall = DPT.objects.processDirs(dirs=days, objtype=pyh.UnityDay, saveLevel=1); \
udall.save(); \
import pickle; \
f = open('udallTimePerformance.pkl', 'wb'); \
pickle.dump(udall.timePerformance, f); \
f.close()" && aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:549596002800:awsnotify --message "UnityDayEarlyJobDone"
