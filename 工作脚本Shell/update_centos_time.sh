#!/bin/sh


ser_time=$(date +%H:%M:%S)


set_time=$(echo "date -s "$ser_time"")

ansible centos -m shell -a "$set_time"

