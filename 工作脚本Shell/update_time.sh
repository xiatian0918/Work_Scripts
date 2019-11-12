#!/bin/sh


ser_time=$(date +'%Y-%m-%d')
local_time=$(date +'%H:%M:%S')

final_time=$(echo "Set-Date '$ser_time $local_time'")

ansible data -m win_shell -a "$final_time"
ansible "tgc-test" -m win_shell -a "$final_time"
