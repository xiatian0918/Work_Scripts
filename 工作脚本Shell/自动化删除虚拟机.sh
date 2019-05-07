#!/bin/sh

/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

read -t 18 -p "请输入要删除的虚拟机名称: " vm_name
if [ -z $vm_name ];then
        echo ""
        exit 2
fi

curl -ksX DELETE --header 'Accept: application/json' --header "vmware-api-session-id: $session2" "https://192.168.0.24/rest/vcenter/vm/${vm_name}"|jq .
