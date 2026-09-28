#!/bin/bash
cd /data/picasso
days=$(ls -d [0-9]* | awk '$1 < 20180701')
jids=()
for d in $days; do
  for s in /data/picasso/$d/session*; do
    [[ "$s" == *eye* ]] && continue
    cd "$s" || continue
    jids+=($(sbatch --parsable /data/src/PyHipp/unity-slurm.sh))
  done
done
cd /data/picasso
echo "unity jobs submitted: ${#jids[@]}"
dep=$(IFS=:; echo "${jids[*]}")
sbatch --dependency=afterok:$dep /data/src/PyHipp/uyall-slurm.sh
