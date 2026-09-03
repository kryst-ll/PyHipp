#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo
echo "#==========================================================="
echo "Start Times"
for file in rplpl-slurm*.out rplspl-slurm*.out; do
    [ -f "$file" ] || continue

    echo "==> $file <=="
    mapfile -t timestamps < <(grep "time.struct_time" "$file")
    echo "${timestamps[0]}"
    echo
done

echo
echo "End Times"
for file in rplpl-slurm*.out rplspl-slurm*.out; do
    [ -f "$file" ] || continue

    echo "==> $file <=="
    tail -n 5 "$file" # print last 5 lines
    echo
done

echo "#==========================================================="
