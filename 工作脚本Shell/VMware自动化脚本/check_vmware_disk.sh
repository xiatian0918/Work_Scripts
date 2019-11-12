#!/bin/sh

/usr/bin/php  /root/session.php >/tmp/session_id.txt
session=$(tail -1 /tmp/session_id.txt)


curl -ksX GET --header 'Accept: application/json' --header "vmware-api-session-id:$session" 'https://192.168.0.24/rest/vcenter/datastore'|python -m json.tool|grep -B 3 lun|egrep -v "data|--">/tmp/disk.txt

for i in `cat /tmp/disk.txt|cut -d: -f 2|grep -v lun|cut -d, -f1`;do a=`echo "scale=2;$i/1024/1024/1024"|bc`;echo $a>>/tmp/disk2;done

cat /tmp/disk2|awk '!(NR%2)' >/tmp/disk4

cat >> /tmp/disk3 <<EOF
磁盘lun_01
磁盘lun_02
磁盘lun_03
EOF

awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /tmp/disk3 /tmp/disk4 >/tmp/disk5
cat /tmp/disk5|sed 's# #  #g'|sed 's/$/\M/'
#for a in `cat /tmp/disk5|sed 's# #   #g'`;do echo "$a"m/s;done
rm -rf /tmp/disk*
