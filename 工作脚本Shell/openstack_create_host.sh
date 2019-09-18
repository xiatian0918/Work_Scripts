#!/bin/bash
# 时间：2019-09-18
# 编写人：夏天
# 描述：此脚本是在OpenStack虚拟化环境下自动化创建虚拟机

# 加载进度条
function jindutiao(){
i=0
str=""
label=('|' '/' '-' '\\')
index=0
while [ $i -le 20 ]
do
    let index=i%4
    let jinshu=$i*5
    printf "\e[47m\e[31m[%-20s]\e[0m\e[47;32m[%c]\e[1;0m\e[47;35m[%-3d%%]\e[1;0m\r" $str ${label[$index]} $jinshu
    let i++
    str+="#"
    sleep 0.5
done
echo
}


# 获取网络ID号
#/bin/sh /root/demo-openstack.sh
/bin/sh /root/admin-openstack.sh
net_id=$(openstack network list|awk '{print $2}'|egrep "[0-9]|-")

# 获取输入创建虚拟机名称
read -t 30 -p "请输入要创建的虚拟机名称: " host_name

if [ -z $host_name ];then
	echo "请输入合理的虚拟机名称"
	exit 8
fi


# 创建虚拟机
openstack server create --flavor 中测新图虚拟机 --image centos7.4  --nic net-id=${net_id} --security-group default --key-name mykey ${host_name} &>/dev/null

echo "*********************************"
echo "虚拟机正在创建过程中,请耐心等待"

jindutiao

# 验证虚拟机是否创建成功
verfi=$(openstack server list|grep "${host_name}"|cut -d'|' -f4|sed 's# ##g')

if [ $verfi == "ACTIVE" ];then
	echo "恭喜,虚拟机(${host_name})创建成功!"
else
	echo "对不起，虚拟机(${host_name})创建失败!"
fi
