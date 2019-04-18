#!/bin/sh

/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

curl -ksX GET --header "Accept: application/json" --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm"|jq . >/tmp/vmware_host.txt

cd /tmp/

cat vmware_host.txt |egrep "name|vm"|cut -d, -f1|awk 'NR%2'|cut -d: -f2|awk -F\" '{print $2}' >vmware_name
cat vmware_host.txt |egrep "name|vm"|cut -d, -f1|awk '!(NR%2)'|cut -d: -f2|awk -F\" '{print $2}' >vmware_vm

awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' vmware_name vmware_vm >vmware_name.txt

rm -rf vmware_name vmware_vm vmware_host.txt

read -t 10 -p "请输入要更改的虚拟机硬件资源的IP地址：" host
if [ -z $host ];then
        exit 1
fi

vm_name=$(cat /tmp/vmware_name.txt |grep $host|awk '{print $2}')

read -t 10 -p "请输入要更改的虚拟机内存为(MB):" core
if [ -z $core ];then
        exit 1
fi



a=$(curl -ksX PATCH --header "Content-Type: application/json" --header "Accept: application/json" --header "vmware-api-session-id:"$session2""  -d '{"spec": { "hot_add_enabled": false, "size_MiB": "'"$core"'" }}' "https://192.168.0.24/rest/vcenter/vm/"$vm_name"/hardware/memory"|jq .)

#echo $a

if [ -z $a ];then
 	echo "你要修改的虚拟机：${host}，修改后的内存资源为：${core}MB,已修改成功"
else
 	echo "修改内存资源失败！"
fi
 
