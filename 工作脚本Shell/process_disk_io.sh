#!/bin/sh
# 时间：2019-07-22
# 编写人：夏天
# 描述： 此脚本是通过使用ansible批量管理工具，批量收集各计算节点的磁盘IO值

ansible 'tgc-test' -m win_shell -a 'python c:\\get_disk.py'|grep -v "FAILED" >/tmp/1.txt

#for i in `cat /mnt/monitor_data/vm_ip/vm_vm_ip.txt`;do python /data/scripts/remote_tgc_node.py $i;done >/mnt/monitor_data/disk_io/tgc_disk_io.txt

cat /tmp/1.txt |grep '^192'|awk '{print $1}'>/tmp/2.txt
cat /tmp/1.txt |grep '^sdisk'>/tmp/3.txt
for i in `cat /tmp/2.txt`;do
	awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /tmp/2.txt /tmp/3.txt >> /mnt/monitor_data/disk_io/tgc_io_data.txt
done

cat /mnt/monitor_data/disk_io/tgc_io_data.txt|sort|uniq >/mnt/monitor_data/disk_io/tgc_disk_io.txt
rm -rf /tmp/*.txt 
rm -rf /mnt/monitor_data/disk_io/tgc_io_data.txt
