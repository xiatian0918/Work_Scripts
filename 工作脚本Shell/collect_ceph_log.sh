#!/bin/sh
# 时间：2019-06-11
# 编写人：夏天
# 这个脚本是使用跳转机远程收集各CEPH集群服务器中的ceph.log日志，并保存在共享存储中

day_time=$(date +"%Y%m%d")
for i in 192.168.0.{25..27};do ssh $i "cat /var/log/ceph/ceph.log" >>/mnt/system/ceph_toprs_log/ceph_`date +"%Y%m%d"`.log;done
