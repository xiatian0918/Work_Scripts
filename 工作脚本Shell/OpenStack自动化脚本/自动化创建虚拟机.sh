#!/bin/bash
# 时间：2019-09-18
# 编写人：夏天
# 描述：此脚本是在OpenStack虚拟化环境下自动化创建虚拟机

source /root/admin-openstack.sh
. /root/admin-openstack.sh

host_cpu=$1
host_mem=$2

moban=$(openstack flavor list|grep toprs-mu|wc -l)
if [ $moban -ne 0 ];then
	openstack flavor delete toprs-mu
fi
openstack flavor create --vcpus $host_cpu --ram $host_mem --disk 10 toprs-mu

# 获取网络ID号
source /root/demo-openstack.sh
. /root/demo-openstack.sh

net_id=$(openstack network list|awk '{print $2}'|egrep "[0-9]|-")
# 获取输入创建虚拟机名称
host_name=$3

if [ -z $host_name ];then
    echo "请输入合理的虚拟机名称"
    exit 8
fi


# 创建虚拟机
openstack server create --flavor toprs-mu --image centos7.4  --nic net-id=${net_id} ${host_name} &>/dev/null
echo "*********************************"
echo "虚拟机正在创建过程中,请耐心等待"
#color_jindutiao
sleep 1m

# 验证虚拟机是否创建成功
verfi=$(openstack server list|grep "${host_name}"|cut -d'|' -f4|sed 's# ##g')
if [ $verfi == "ACTIVE" ];then
#    echo "恭喜,虚拟机(${host_name})创建成功!"
    /bin/echo -e "\033[32m 恭喜,虚拟机(${host_name})创建成功! \033[0m"
else
#    echo "对不起，虚拟机(${host_name})创建失败!"
    /bin/echo -e "\033[31m 对不起，虚拟机(${host_name})创建失败! \033[0m"
fi

## --------------------------------------获取创建后的虚拟机IP地址
#echo ""
#echo "正在获取创建后的虚拟机IP地址"
#sleep 2
#source /root/demo-openstack.sh
#. /root/demo-openstack.sh
# 获取创建后的虚拟机ID号
#host_id=$(openstack server list|grep ${host_name}|cut -d'|' -f2|sed 's# ##g')
#long_jindutiao
#ssh 192.168.56.12 "/bin/cat /var/lib/nova/instances/${host_id}/console.log|grep "eth0" " >/tmp/1.txt
#ip_address=$(cat /tmp/1.txt |head -1|cut -d'|' -f4|sed 's# ##g')
#\rm -rf /tmp/1.txt
#/bin/echo -e "\033[33m 创建后的虚拟机IP地址为: ${ip_address} \033[0m"
