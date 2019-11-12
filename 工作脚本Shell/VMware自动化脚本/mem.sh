#!/bin/sh

vm_name=$1
mem=$2

#[ $# -ne 2 ] && {
#	echo "USAGE: sh $0 args1 args2"
#}

#read -t 10 -p "请输入要更改的虚拟机名称：" vm_name
#if [ -z $vm_name ];then
#        exit 1
#fi

#read -t 10 -p "请输入要更改的虚拟机CPU核数为：" core
#if [ -z $core ];then
#        exit 1
#fi


/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

a=$(echo $vm_name|cut -d"-" -f1)

host_name=$(curl -ksX GET --header "Accept: application/json" --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm"|jq . |grep "$a"|cut -d':' -f2|awk -F\" '{print $2}')

echo -e "\033[31m在当前虚拟化环境中名称为:"$a"名称命名的虚拟机有:\n$host_name  \033[0m"

name_vm=$(curl -ksX GET --header "Accept: application/json" --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm"|jq . |grep "$vm_name" -C2|grep vm|cut -d':' -f2|awk -F\" '{print $2}')

#a=$(curl -ksX PATCH --header "Content-Type: application/json" --header "Accept: application/json" --header "vmware-api-session-id:"$session2""  -d '{"spec": { "count": "'"$mem"'", "hot_add_enabled": false, "hot_remove_enabled": false, "cores_per_socket": 1}}' "https://192.168.0.24/rest/vcenter/vm/"$name_vm"/hardware/cpu"|jq .)

b=$(curl -ksX PATCH --header "Content-Type: application/json" --header "Accept: application/json" --header "vmware-api-session-id:"$session2""  -d '{"spec": { "hot_add_enabled": false, "size_MiB": "'"$mem"'" }}' "https://192.168.0.24/rest/vcenter/vm/"$name_vm"/hardware/memory"|jq .)

if [ -z $b ];then
 	echo "你要修改的虚拟机：${vm_name}，修改后的内存资源为：${mem},已修改成功"
else
 	echo "修改内存资源失败！"
fi
 
