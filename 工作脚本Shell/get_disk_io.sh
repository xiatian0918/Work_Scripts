#!/bin/sh
# 时间：2019-07-08
# 编写人：夏天
# 描述：此脚本是监控各计算节点的磁盘IO值

[ -f "/mnt/monitor_data/disk_io/disk_io.txt" ] && rm -rf /mnt/monitor_data/disk_io/disk_io.txt

for i in `ls /mnt/monitor_data/disk_io/;`
do 
	#disk read io
	read_by=$(cat $i|awk -F\( '{print $2}'|cut -d',' -f3|cut -d '=' -f2)
	read_time=$(cat $i|awk -F\( '{print $2}'|cut -d',' -f5|cut -d'=' -f2)
	read_value=$(echo "scale=2;$read_by / $read_time / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')

	#disk write io
	write_by=$(cat $i|awk -F\( '{print $2}'|cut -d',' -f4|cut -d'=' -f2)
	write_time=$(cat $i|awk -F\( '{print $2}'|cut -d',' -f6|cut -d'=' -f2|awk -F\) '{print $1}')
	write_value=$(echo "scale=2;$write_by / $write_time / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	
#	echo "$i   read_io("$read_value" M/S)    write_io("$write_value"M/S)" >>/mnt/monitor_data/disk_io/disk_io.txt
	echo "`echo $i|cut -d'_' -f1`    read_io("$read_value" M/S)    write_io("$write_value"M/S)" >>/mnt/monitor_data/disk_io/disk_io.txt

done
