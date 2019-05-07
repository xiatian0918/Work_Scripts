#!/bin/sh


ser_time=$(ssh 192.168.0.52 "date +%H:%M:%S")
local_time=$(date +'%H:%M:%S')

if [ $local_time != $ser_time ];then
	date -s "$ser_time"
fi
