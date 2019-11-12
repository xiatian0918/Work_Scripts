#!/bin/sh
# 时间: 2019-06-27
# 编写人: 夏天
# 描述: 此脚本是获取磁盘读写IOPSx_get -s 192.168.0.11 -k 'perf_counter[\2\16]'


ip_addr=$1

if [ $# -ne 1 ];then
	echo USAGE:pleases input correct ip address thanks!
	exit 4
fi

read=$(zabbix_get -s "$ip_addr" -k 'perf_counter[\2\16]')
write=$(zabbix_get -s "$ip_addr" -k 'perf_counter[\2\18]')

final_read=$(echo "scale=2;$read / 1024" |bc)
final_write=$(echo "scale=2;$write / 1024" |bc)

echo "此节点("$ip_addr")的读带宽为:${final_read}k/s"
echo "此节点("$ip_addr")的写带宽为:${final_write}k/s"

