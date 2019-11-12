#!/bin/bash
# 时间：2019-11-12
# 编写人：Xiatian
# 描述：此脚本是修改OpenStack下创建的虚拟机cpu与内存资源

source /root/admin-openstack.sh
. /root/admin-openstack.sh

vm_name=$1
vm_cpu=$2
vm_mem=$3
vm_disk=$4

#创建实例类型
openstack flavor create --vcpus $vm_cpu --ram $vm_mem --disk $vm_disk ${vm_name}_flavor

sleep 2

#获取新建虚拟机ID号
source /root/demo-openstack.sh
. /root/demo-openstack.sh
vm_id=$(openstack server list|grep "$vm_name"|cut -d'|' -f2|awk '{print $1}')

#获取flavor编号
flavor_id=$(openstack flavor list|grep ${vm_name}_flavor|cut -d'|' -f2|awk '{print $1}')

#修改虚拟机资源
nova resize $vm_id $flavor_id

sleep 2m
#确认修改后的虚拟机资源
confirm_status=$(nova list|grep "$vm_name"|cut -d'|' -f4|awk '{print $1}')
if [ ${confirm_status} == "VERIFY_RESIZE" ];then 
	nova resize-confirm $vm_id
fi

#删除实例类型
source /root/admin-openstack.sh
. /root/admin-openstack.sh

openstack flavor delete $flavor_id

#验证是否修改资源成功
source /root/demo-openstack.sh
. /root/demo-openstack.sh

resource_status=$(nova show $vm_name|egrep "flavor:vcpus|flavor:ram|flavor:disk"|grep vcpus|cut -d'|' -f3|awk '{print $1}')
if [ "$resource_status" == "$vm_cpu" ];then
	echo "资源修改成功"
else
	echo "资源修改失败"
fi

