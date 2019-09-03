#!/bin/sh
# date:2019-05-05 

now_time=$(date +"%Y%m%d")

#ip_addr=('192.168.0.25' '192.168.0.26' '192.168.0.27' '192.168.0.28')

for i in 192.168.0.{25..28};do echo $i;ssh $i "cat /var/log/messages|grep -i error";echo "";done >/mnt/system/error_message_log/error.log

line=$(cat /mnt/system/error_message_log/error.log |egrep -v "192.168|^$"|wc -l)
if [ $line -ne 0 ];then
	echo "当前CEPH集群服务器Messages日志中出现错误信息"|mail -s "CEPH集群服务器告警" "2831315100@qq.com,18810434724@163.com"
fi
