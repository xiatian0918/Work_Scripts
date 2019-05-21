#!/bin/sh
# time:2019-05-14
# author:HotXia
# this is about how get mongodb replication port scripts

/usr/local/mongodb/bin/mongo 192.168.0.59:27018/admin --eval "printjson(rs.status())" |egrep "name|stateStr"|awk -F\, '{print $1}'|awk '{print $3}'|awk -F\" '{print $2}'|sed -n '1~2p' >/tmp/mongo_port

/usr/local/mongodb/bin/mongo 192.168.0.59:27018/admin --eval "printjson(rs.status())" |egrep "name|stateStr"|awk -F\, '{print $1}'|awk '{print $3}'|awk -F\" '{print $2}'|sed -n '2~2p' >/tmp/mongo_status

awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /tmp/mongo_port /tmp/mongo_status >/tmp/mongo_info

cat /tmp/mongo_info

\rm -rf /tmp/mongo_port /tmp/mongo_status /tmp/mongo_info 
