#!/bin/sh
# 时间：2019-06-18
# 编写人：夏天
# 描述：此脚本是安装GlusterFS服务并且配置分布式复制卷

cluster=$1
[ $# -ne 1 ] && {
	echo "USAGE:Please enter the correct ip address!"
	exit 1
}

yum install centos-release-gluster -y
yum install glusterfs-server -y
/usr/bin/systemctl start glusterfsd

/usr/bin/systemctl start glusterd

for i in centos-release-gluster glusterfs-server;do ssh $1 "yum install -y $i";done
for s in glusterfsd glusterd;do ssh $1 "/usr/bin/systemctl start $s;/usr/bin/systemctl enable $s";done
gluster peer probe $1

echo "接下来开始创建分布式卷"

mkdir -p /data/gluster1    
mkdir -p /data/gluster2 

ssh $1 "mkdir -p /data/gluster1;mkdir -p /data/gluster2"
local_ip=$(ip add|awk '/inet/ {print $2}' |grep "^192"|awk -F\/ '{print $1}'|grep -v "1$")

gluster volume create tgc-volume replica 2 "$local_ip":/data/gluster1 "$1":/data/gluster1 "$local_ip":/data/gluster2 "$1":/data/gluster2  force

gluster volume start tgc-volume
mkdir -p /mnt/glusterfs/data
mount.glusterfs $1:tgc-volume /mnt/glusterfs/data

