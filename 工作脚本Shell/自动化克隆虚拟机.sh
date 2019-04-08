#!/bin/sh
#author:xiatian

read -t 8 -p "请输入Vcenter的IP地址: " ip_addr
if [ -z $ip_addr ];then 
	echo ""
	exit 2
fi

read -t 18 -p "请输入Vcenter的用户名: " vc_name
if [ -z $vc_name ];then
        echo ""
        exit 2
fi


read -t 18 -p "请输入Vcenter的密码: " vc_passwd
if [ -z $vc_passwd ];then
        echo ""
        exit 2
fi

read -t 18 -p "请输入要克隆的虚拟机模板: " vm_tem
if [ -z $vm_tem ];then
        echo ""
        exit 2
fi

read -t 18 -p "请输入克隆后的虚拟机名称为: " vm_name
if [ -z $vm_name ];then
        echo ""
        exit 2
fi


/bin/python /data/scripts/clone_vm.py -s "$ip_addr" -u "$vc_name" -p "$vc_passwd" --template "$vm_tem" -v "$vm_name" --power-on 
