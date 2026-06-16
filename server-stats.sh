#!/usr/bin/env bash

vmstat | awk '{print $13}' | nl | grep 2 |  awk '{print "CPU usage: "$2"%"}'

free | awk '/Mem:/ {printf "Memory: %.2f GiB / %.2f GiB\n", $3/1048576, $2/1048576}'

df | sed 1d | awk '{printf "Disk:  %.2f GiB / %.2f GiB \n", $3/1048576, $2/1048576}' | head -1

echo "5 Heaviest running CPU processes:"
CORE_COUNT=$(nproc)
ps aux --sort=-pcpu | awk -v cores="$CORE_COUNT" 'NR>1 {print $11, $3/cores "%"} NR==6 {exit}' | nl

echo "5 Heaviest running RAM processes:"
ps aux --sort=-pmem | awk 'NR>1 {print $11, $4"%"} NR==6 {exit}' |nl
