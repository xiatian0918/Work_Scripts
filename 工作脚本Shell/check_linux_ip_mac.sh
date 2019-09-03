#!/bin/sh
# 时间：2019-08-24
# 编写人：夏天
# 脚本描述： 此脚本是获取所有linux节点的IP地址与MAC地址


version=$(cat /etc/redhat-release |awk '{ print $(NF-1) }'|cut -d'.' -f1)


if [ $version -eq 6 ];then
	ifconfig|grep "^e" -C 4|egrep "HWaddr|ether" |awk '{print $NF}'
elif [ $version -eq 7 ];then
 	ifconfig|grep "^e" -C 4|egrep "HWaddr|ether"|awk '{print $2}'
fi
