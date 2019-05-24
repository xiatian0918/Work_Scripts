#!/bin/sh
# time:2019-05-23
# author:xiatian
# 这是一个获取EXSI集群总的CPU、内存、磁盘已用大小脚本

# CPU资源
ip_exsi=('192.168.0.21' '192.168.0.22' '192.168.0.23')

for i in ${ip_exsi[@]}
do
	/usr/lib/nagios/plugins/check_esx3.pl -H $i -u'root' -p'Toprs!@#123' -l cpu -s usage|awk '{print $5}'|awk -F\= '{print $2}' >>/mnt/monitor_data/vm_monitor/exsi_cpu.txt
done


#磁盘资源
lun_01=$(/usr/lib/nagios/plugins/check_esx3.pl -H 192.168.0.21 -u root -p'Toprs!@#123' -l vmfs -x EQ_LUN9,EQ_LUN8 -s lun_01|awk '{print $6}'|awk -F\( '{print $2}'|awk -F\) '{print $1}'|awk -F\% '{print $1}')
lun_02=$(/usr/lib/nagios/plugins/check_esx3.pl -H 192.168.0.22 -u root -p'Toprs!@#123' -l vmfs -x EQ_LUN9,EQ_LUN8 -s lun_02|awk '{print $6}'|awk -F\( '{print $2}'|awk -F\) '{print $1}'|awk -F\% '{print $1}')
lun_03=$(/usr/lib/nagios/plugins/check_esx3.pl -H 192.168.0.23 -u root -p'Toprs!@#123' -l vmfs -x EQ_LUN9,EQ_LUN8 -s lun_03|awk '{print $6}'|awk -F\( '{print $2}'|awk -F\) '{print $1}'|awk -F\% '{print $1}')

echo "scale=2;100.00-$lun_01"|bc >/mnt/monitor_data/vm_monitor/exsi_disk.txt
echo "scale=2;100.00-$lun_02"|bc >>/mnt/monitor_data/vm_monitor/exsi_disk.txt
echo "scale=2;100.00-$lun_03"|bc >>/mnt/monitor_data/vm_monitor/exsi_disk.txt


#内存资源

for h in ${ip_exsi[@]}
do
	/usr/lib/nagios/plugins/check_esx3.pl -H $h -u'root' -p'Toprs!@#123' -l mem -s usage|awk '{print $5}'|awk -F\= '{print $2}' >>/mnt/monitor_data/vm_monitor/exsi_mem.txt
done


#合并资源 CPU、磁盘、内存

awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /mnt/monitor_data/vm_monitor/exsi_cpu.txt /mnt/monitor_data/vm_monitor/exsi_disk.txt  >/mnt/monitor_data/vm_monitor/exsi_num1.txt
awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /mnt/monitor_data/vm_monitor/exsi_num1.txt /mnt/monitor_data/vm_monitor/exsi_mem.txt >/mnt/monitor_data/vm_monitor/exsi_total_new.txt
\rm -rf /mnt/monitor_data/vm_monitor/exsi_cpu.txt /mnt/monitor_data/vm_monitor/exsi_disk.txt /mnt/monitor_data/vm_monitor/exsi_mem.txt /mnt/monitor_data/vm_monitor/exsi_num1.txt

cpu_value=$(awk '{ sum += $1 } END { printf("%.2f\n", sum )}' /mnt/monitor_data/vm_monitor/exsi_total_new.txt)
disk_value=$(awk '{ sum += $2 } END { printf("%.2f\n", sum )}' /mnt/monitor_data/vm_monitor/exsi_total_new.txt)
mem_value=$(awk '{ sum += $3 } END { printf("%.2f\n", sum )}' /mnt/monitor_data/vm_monitor/exsi_total_new.txt)

cpu_final_value=$(echo "scale=2;$cpu_value/3"|bc)
disk_final_value=$(echo "scale=2;$disk_value/3"|bc)
mem_final_value=$(echo "scale=2;$mem_value/3"|bc)

echo $cpu_final_value    $disk_final_value    $mem_final_value >/mnt/monitor_data/vm_monitor/exsi_total.txt
\rm -rf /mnt/monitor_data/vm_monitor/exsi_total_new.txt

