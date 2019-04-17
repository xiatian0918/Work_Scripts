#!/bin/sh

for i in *******.{21..23};do cat /tmp/inter.txt|grep "$i" -A13 >/tmp/"$i".txt;done

a=(*******.21 *******.22 *******.23)

echo -e "\033[41;37m 虚拟化计算节点端口如下:  \033[0m"
echo "-----------------------------------------------"

echo -e "\033[31m计算节点:"${a[0]}"  \033[0m"
cat /tmp/${a[0]}.txt|grep "vmnic"|awk '{print $1}'
cat /tmp/${a[0]}.txt|grep "Aggregation"|awk '{print $2,$3}'
cat /tmp/${a[0]}.txt|grep "interface"|awk '{print $2}'

echo ""
echo -e "\033[33m计算节点:"${a[1]}"  \033[0m"
cat /tmp/${a[1]}.txt|grep "vmnic"|awk '{print $1}'
cat /tmp/${a[1]}.txt|grep "Aggregation"|awk '{print $2,$3}'
cat /tmp/${a[1]}.txt|grep "interface"|awk '{print $2}'
echo ""

echo -e "\033[34m计算节点:"${a[2]}"  \033[0m"
cat /tmp/${a[2]}.txt|grep "vmnic"|awk '{print $1}'
cat /tmp/${a[2]}.txt|grep "Aggregation"|awk '{print $2,$3}'
cat /tmp/${a[2]}.txt|grep "interface"|awk '{print $2}'
