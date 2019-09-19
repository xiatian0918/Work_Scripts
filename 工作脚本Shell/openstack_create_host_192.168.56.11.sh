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

# 多彩进度条
function color_jindutiao(){
i=0;
str=""
arr=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
  let index=i%4
  let indexcolor=i%8
  let color=30+indexcolor
  printf "\e[0;$color;1m[%-100s][%d%%]%c\r" "$str" "$i" "${arr[$index]}"
  sleep 0.5
  let i++
  str+='='
done
printf "\n"
}

# 长时间加载进度条彩色
function long_jindutiao(){
i=0;
str=""
arr=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
  let index=i%4
  let indexcolor=i%8
  let color=30+indexcolor
  printf "\e[0;$color;1m[%-100s][%d%%]%c\r" "$str" "$i" "${arr[$index]}"
  sleep 3
  let i++
  str+='='
done
printf "\n"
}



# 获取网络ID号
source /root/demo-openstack.sh
. /root/demo-openstack.sh
net_id=$(openstack network list|awk '{print $2}'|egrep "[0-9]|-")

# 获取输入创建虚拟机名称
read -t 30 -p "请输入要创建的虚拟机名称: " host_name

if [ -z $host_name ];then
	echo "请输入合理的虚拟机名称"
	exit 8
fi


# 创建虚拟机
openstack server create --flavor 中测新图虚拟机 --image centos7.2  --nic net-id=${net_id} ${host_name} &>/dev/null

echo "*********************************"
echo "虚拟机正在创建过程中,请耐心等待"

color_jindutiao

# 验证虚拟机是否创建成功
verfi=$(openstack server list|grep "${host_name}"|cut -d'|' -f4|sed 's# ##g')

if [ $verfi == "ACTIVE" ];then
#	echo "恭喜,虚拟机(${host_name})创建成功!"
	/bin/echo -e "\033[32m 恭喜,虚拟机(${host_name})创建成功! \033[0m"
else
#	echo "对不起，虚拟机(${host_name})创建失败!"
	/bin/echo -e "\033[31m 对不起，虚拟机(${host_name})创建失败! \033[0m"
fi

# --------------------------------------获取创建后的虚拟机IP地址
echo ""
echo "正在获取创建后的虚拟机IP地址"
sleep 2
source /root/demo-openstack.sh
. /root/demo-openstack.sh

# 获取创建后的虚拟机ID号

host_id=$(openstack server list|grep ${host_name}|cut -d'|' -f2|sed 's# ##g')
long_jindutiao

ssh 192.168.56.12 "/bin/cat /var/lib/nova/instances/${host_id}/console.log|grep "eth0" " >/tmp/1.txt
ip_address=$(cat /tmp/1.txt |head -1|cut -d'|' -f4|sed 's# ##g')
#\rm -rf /tmp/1.txt

/bin/echo -e "\033[33m 创建后的虚拟机IP地址为: ${ip_address} \033[0m"



