#!/bin/sh

host=$1

sudo /usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

curl -ksX GET --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" 'https://192.168.0.24/rest/vcenter/vm'|jq . >/tmp/vmware_host.txt

vm_name=$(cat /tmp/vmware_host.txt|grep "$host" -A1|grep "vm-"|cut -d':' -f2|awk -F\" '{print $2}')

curl -skX POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header "vmware-api-session-id: ${session2}" "https://192.168.0.24/rest/vcenter/vm/"$vm_name"/power/reset"

