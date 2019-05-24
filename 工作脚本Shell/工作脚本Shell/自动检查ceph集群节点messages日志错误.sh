#!/bin/sh
# date:2019-05-05 

now_time=$(date +"%Y%m%d")

if [ -f /var/log/messages ];then
	error_line=$(/usr/bin/cat /var/log/messages|grep -i error|wc -l)
	if [ ${error_line} -gt 0 ];then
		/usr/bin/cat /var/log/messages|grep -i error >/tmp/ceph_`ifconfig|egrep "bond0|inet"|grep 192|awk '{print $2}'|head -1`_error_messages.log
		scp -r /tmp/ceph_`ifconfig|egrep "bond0|inet"|grep 192|awk '{print $2}'|head -1`_error_messages.log root@192.168.0.62:/mnt/system/error_message_log/
	else
		exit 6
	fi
else
	exit 6
fi

