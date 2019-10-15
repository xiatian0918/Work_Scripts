#!/bin/sh
# 时间：2019-10-14
# 编写人：夏天
# 脚本描述：此脚本是把云平台环境中通过接口自动化创建的虚拟机的监控信息写入到MySQL数据库中

#清理MySQL数据表
mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'DELETE FROM tb_monitor_vm;'
mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'truncate tb_monitor_vm;'

#写入数据到MySQL中
for vm_name in `cat /mnt/monitor_data/temp_ip/vm_name.txt|awk '{print $1}'`
do

	#写入虚拟机CPU信息
	ip_address=$(cat /mnt/monitor_data/temp_ip/vm_name.txt|grep "$vm_name"|awk '{print $2}')
	cpu_info=$(/usr/lib/centreon/plugins/centreon_linux_snmp.pl --plugin=os::linux::snmp::plugin --mode=cpu --hostname="$ip_address" \
	--snmp-version='2c' --snmp-community='VSJPg7Gpm0Z08hbR' --warning='85' --critical='90'|cut -d'|' -f1|awk '{print $NF}')


	#写入内存信息
#	mem_info=$(python /data/scripts/monitor_data/remote_node.py "$ip_address"|awk '{print $4,$5}')


	#写入内存用量
	mem_use=$(/usr/lib/nagios/plugins/check_nt -H "$ip_address" -p 12489 -v MEMUSE -w 80 -c 90|cut -d'|' -f1|cut -d'-' -f2|awk '{print $NF}'|awk -F\( '{print $2}'|awk -F\) '{print $1}')

	
	#写入读IO值
	read_value=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f3|cut -d '=' -f2)
	read_time=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f5|cut -d'=' -f2)
	read_num=$(echo "scale=2;$read_value / $read_time / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	read_io="$read_num M/S"


	#写入写IO值
	write_value=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f4|cut -d'=' -f2)
	write_time=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f6|cut -d'=' -f2|awk -F\) '{print $1}')
	write_num=$(echo "scale=2;$write_value / $write_time / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	write_io="$write_num M/S"



	#接收带宽
	receive_band=$(python /data/scripts/monitor_data/remote_daikuan.py "$ip_address"|egrep "^Bytes"|awk '{print $2}')
	receive_value=$(echo "scale=2;$receive_band / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	receive_num="$receive_value M"


	#发送带宽
	send_band=$(python /data/scripts/monitor_data/remote_daikuan.py "$ip_address"|egrep "^Bytes"|awk '{print $3}')
	echo $send_band >>/tmp/send_band.txt
	dos2unix /tmp/send_band.txt &>/dev/null
	for s in `cat /tmp/send_band.txt`;do send_value=$(echo "scale=2;$s / 1024 / 1024"|bc| awk '{printf "%.2f", $0}');done
	send_num="$send_value M"


	#写入MySQL表中的操作命令
#	mysql_vm_name="INSERT tb_monitor_vm(vm_name,cpu_use,memory,memory_use,write_io,read_io,bandwidth_in,bandwidth_out) \

	mysql_vm_name="INSERT tb_monitor_vm(vm_name,cpu_use,memory_use,write_io,read_io,bandwidth_in,bandwidth_out) \
	VALUES('$vm_name','$cpu_info','$mem_use','$write_io','$read_io','$receive_num','$send_num');"
	mysql -h192.168.0.53 -uroot -p123456789 toprs -e "${mysql_vm_name}"

done
\rm -rf /tmp/send_band.txt
