#!/bin/sh

md51=$(md5sum /mnt/monitor_data/vm_ip/vm_vm_ip.txt|awk '{print $1}')
sleep 1m
md52=$(md5sum /mnt/monitor_data/vm_ip/vm_vm_ip.txt|awk '{print $1}')

if [ "$md52" != "$md51" ];then
        sed -i '26,$d' /etc/ansible/hosts
	for i in `cat /mnt/monitor_data/vm_ip/vm_vm_ip.txt `
	do
		echo -e "$i ansible_user=\"administrator\" ansible_password=\"Toprs!@#123\" ansible_port=5985 ansible_connection=\"winrm\" ansible_winrm_server_cert_validation=ignore" >>/etc/ansible/hosts
	done
fi
