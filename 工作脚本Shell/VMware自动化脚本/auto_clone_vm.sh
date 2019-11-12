#!/bin/sh
#author:xiatian

ip_addr=192.168.0.24
vc_name="administrator@vsphere.local"
vc_passwd="Toprs!@#123"

vm_tem=$1
vm_name=$2


[ -f "/mnt/monitor_data/dhcp_ip/ip.list" ] && \rm -rf /mnt/monitor_data/dhcp_ip/ip.list
#date_now=$(date +'%Y-%m-%d %H:%M:%S')
/bin/python /data/scripts/clone_vm.py -s "$ip_addr" -o '443' -u "$vc_name" -p "$vc_passwd" --template "$vm_tem" -v "$vm_name" --power-on 

if [ $? -eq 0 ];then
	sleep 2
	ssh 192.168.0.65 '/bin/sh /root/vmware_api/重启克隆虚拟机网卡.sh'
fi

sleep 1m

for i in 192.168.0.{91..110};do
       	/usr/lib/nagios/plugins/check_icmp -H $i &>/dev/null
       	[ $? -eq 0 ] && echo "$i" >>/mnt/monitor_data/dhcp_ip/ip.list
done

sleep 5

ssh 192.168.0.67 "/bin/sh /root/pyvmomi-community-samples-master/samples/get_hostname_ip.sh"

