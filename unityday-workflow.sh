#!/bin/bash
cd /data/picasso
days=$(ls -d [0-9]* | awk '$1 < 20180701')
udjids=()
for d in $days; do
  ujids=()
  for s in /data/picasso/$d/session*; do
    [[ "$s" == *eye* ]] && continue
    cd "$s" || continue
    ujids+=($(sbatch --parsable /data/src/PyHipp/unity-slurm.sh))
  done
  cd "/data/picasso/$d" || continue
  dep=$(IFS=:; echo "${ujids[*]}")
  udjids+=($(sbatch --parsable --dependency=afterok:$dep /data/src/PyHipp/unityday-slurm.sh))
done
cd /data/picasso
echo "unityday jobs submitted: ${#udjids[@]}"
dep=$(IFS=:; echo "${udjids[*]}")
sbatch --dependency=afterok:$dep /data/src/PyHipp/udall-slurm.sh
