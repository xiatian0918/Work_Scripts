#!/bin/sh

time2=`date -d '5 minutes ago' +%s`
time3=`date -d '10 minutes ago' +%s`


wget -O exsi_21 "http://192.168.0.65:8080/cacti/graph_xport.php?local_graph_id=11&rra_id=0&view_type=tree&graph_start=${time3}&graph_end=${time2}"&>/dev/null

[ ! -d /tmp/daikuan ] && mkdir -p /tmp/daikuan
mv exsi_21 /tmp/daikuan

a=$(tail -1 /tmp/daikuan/exsi_21 |awk -F \, '{print $3}'|awk -F \" '{print $2}'|awk -F \e '{print $1}')
b=$(tail -1 /tmp/daikuan/exsi_21 |awk -F \, '{print $3}'|awk -F \" '{print $2}'|awk -F \e '{print $2}'|awk -F \+ '{print $2}')
time1=$(tail -1 /tmp/daikuan/exsi_21|awk -F \, '{print $1}'|awk -F \" '{print $2}')

c=$(echo "scale=2;$a * 10^$b / 1000 / 1000"|bc)

echo "名称: toprs-exsi01-192.168.0.21   时间: $time1     接口名称:bond0     带宽出口流量为: "$c"M"

#rm -rf /tmo/daikuan/*
