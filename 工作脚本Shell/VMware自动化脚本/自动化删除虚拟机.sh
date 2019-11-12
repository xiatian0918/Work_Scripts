#!/bin/sh

name_vm=$1

b=$(echo $name_vm|grep "ceshi"|wc -l)
if [ $b -eq 0 ];then
	echo -e "\033[44;37m 请输入正确的虚拟机名称  \033[0m"
	exit 8
fi

/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

vm_name=$(curl -ksX GET --header "Accept: application/json" --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm"|jq . |grep "$name_vm" -C2|grep vm|cut -d':' -f2|awk -F\" '{print $2}')

curl -ksX POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm/${vm_name}/power/stop" &>/dev/null

sleep 3

curl -ksX DELETE --header 'Accept: application/json' --header "vmware-api-session-id: $session2" "https://192.168.0.24/rest/vcenter/vm/${vm_name}"|jq .
