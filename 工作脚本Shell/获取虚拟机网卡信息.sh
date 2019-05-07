#!/bin/sh

vm=$1
if [ $# -ne 1 ];then
   echo "USAGE:/bin/sh $0 {vm-name}"
   exit 2
fi

/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

curl -ksX GET --header 'Accept: application/json' --header "vmware-api-session-id: $session2" "https://192.168.0.24/rest/vcenter/vm/${vm}/hardware/ethernet"|jq .
