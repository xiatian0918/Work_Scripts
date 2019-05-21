#!/bin/sh

for vm_ip in `cat /mnt/monitor_data/vm_ip/vm_vm_ip.txt`;do
	name=$(python3 /data/scripts/vm_hard_info.py -s'192.168.0.24' -u'administrator@vsphere.local' -p'Toprs!@#123' -i "$vm_ip"|egrep "name"|head -1|awk -F\: '{print $2}' )
	echo $vm_ip 	$name

done

