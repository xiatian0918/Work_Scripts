#!/bin/sh

ansible 192.168.0.82 -m win_shell -a " dir E:\\data1\\" >/opt/1.txt
cat /opt/1.txt |grep tif|awk '{print $5}' >/opt/5.txt
ls -l /mnt/development/upload/ |grep -v "^总">/opt/4.txt
cat /opt/4.txt |awk '{print $NF}' >/opt/6.txt

awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /opt/5.txt  /opt/6.txt > /opt/7.txt

for i in `cat /opt/6.txt`;do a=$(grep $i /opt/7.txt|awk '{print $1}');mv /mnt/development/upload/$i /mnt/development/upload/$a ;done

rm -rf /opt/*.txt
