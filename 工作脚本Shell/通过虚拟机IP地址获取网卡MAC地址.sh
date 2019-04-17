#!/bin/sh
#author:xiatian


read -t 18 -p "请输入要查看虚拟机Vmotion状态的IP地址: " vm_name
if [ -z $vm_name ];then
        echo ""
        exit 2
fi
echo $vm_name >/tmp/vm_name
vm_mi=`cat /tmp/vm_name`
vm_mm=$(/bin/sh /data/www/NETSCOUT公司要求API/获取虚拟主机详细信息.sh|egrep "$vm_mi" -C 5|grep "vm"|cut -d':' -f2|awk -F\, '{print $1}'|awk -F\" '{print $2}')
echo $vm_mm >/tmp/vm_mc
vm_mm2=$(cat /tmp/vm_mc)

vm_nic=$(/bin/sh /data/www/NETSCOUT公司要求API/获取虚拟机网卡信息.sh ${vm_mm2})
vm_nic2=$(echo $vm_nic|awk -F\[ '{print $2}'|cut -d':' -f2|awk -F\} '{print $1}'|awk -F\" '{print $2}')



/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

curl -ksX GET --header 'Accept: application/json' --header "vmware-api-session-id: $session2" "https://*******/rest/vcenter/vm/${vm_mm2}/hardware/ethernet/${vm_nic2}"|jq .|grep mac_address|awk -F\": '{print $2}'|awk -F\, '{print $1}'|awk -F\" '{print $2}'

