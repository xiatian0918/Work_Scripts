#!/bin/bash

vm_ip=$1
#通过名字获取IP地址
vm_name=$(cat /mnt/monitor_data/temp_ip/vm_name.txt |awk '$1=="'$vm_ip'" {print $2}')

#执行重启虚拟机
python /root/pyvmomi-community-samples-master/samples/reboot_vm.py -s 192.168.0.24 -o 443 -u "administrator@vsphere.local" -p 'Toprs!@#123' -i $vm_name 
