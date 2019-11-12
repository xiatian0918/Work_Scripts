#!/bin/bash
# 这是初始化安装脚本

echo "一、安装基础软件包"
rpm -ivh http://192.168.0.62/tools/epel-release-latest-7.noarch.rpm
yum install libgcrypt-devel lrzsz perl-DBI perl-libwww-perl net-snmp-perl  openssl-devel pcre-devel telnet  nfs-utils rpcbind  gcc net-tools -y

echo "二、设置时区"
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

echo "三、关闭防火墙"
sed -i '7 c SELINUX=disabled' /etc/selinux/config
setenforce 0
systemctl stop firewalld.service && systemctl disable firewalld.service

echo "四、更新常用软件包"
yum update -y glibc*
yum update -y openssh
yum update -y bash

echo "五、历史记录格式修改"
echo " export HISTTIMEFORMAT=\" %Y-%m-%d  %H:%M:%S  \`whoami\`  \" ">>/root/.bashrc
\. /root/.bashrc
[ ! -f /usr/sbin/ntpdate ] && yum install ntpdate -y
echo "*/5 * * * * /usr/sbin/ntpdate time1.aliyun.com >/dev/null 2>&1" >>/var/spool/cron/root
\. /root/.bashrc

echo "六、配置静态IP地址"
name=$(hostname|cut -d'-' -f2)
if [ $name == "node1" ];then
	sed -i 's#BOOTPROTO=dhcp#BOOTPROTO=static#' /etc/sysconfig/network-scripts/ifcfg-ens33
	sed -i 's#ONBOOT=no#ONBOOT=yes#' /etc/sysconfig/network-scripts/ifcfg-ens33
	echo "IPADDR=192.168.56.11" >>/etc/sysconfig/network-scripts/ifcfg-ens33
	echo "NETMASK=255.255.255.0" >>/etc/sysconfig/network-scripts/ifcfg-ens33
	echo "GATEWAY=192.168.56.2" >>/etc/sysconfig/network-scripts/ifcfg-ens33
	echo "DNS1=202.106.0.20" >>/etc/sysconfig/network-scripts/ifcfg-ens33

elif [ $name == "node2" ];then
        sed -i 's#BOOTPROTO=dhcp#BOOTPROTO=static#' /etc/sysconfig/network-scripts/ifcfg-ens33
        sed -i 's#ONBOOT=no#ONBOOT=yes#' /etc/sysconfig/network-scripts/ifcfg-ens33
        echo "IPADDR=192.168.56.12" >>/etc/sysconfig/network-scripts/ifcfg-ens33
        echo "NETMASK=255.255.255.0" >>/etc/sysconfig/network-scripts/ifcfg-ens33
        echo "GATEWAY=192.168.56.2" >>/etc/sysconfig/network-scripts/ifcfg-ens33
        echo "DNS1=202.106.0.20" >>/etc/sysconfig/network-scripts/ifcfg-ens33

elif [ $name == "node3" ];then
	sed -i 's#BOOTPROTO=dhcp#BOOTPROTO=static#' /etc/sysconfig/network-scripts/ifcfg-ens33
        sed -i 's#ONBOOT=no#ONBOOT=yes#' /etc/sysconfig/network-scripts/ifcfg-ens33
        echo "IPADDR=192.168.56.13" >>/etc/sysconfig/network-scripts/ifcfg-ens33
        echo "NETMASK=255.255.255.0" >>/etc/sysconfig/network-scripts/ifcfg-ens33
        echo "GATEWAY=192.168.56.2" >>/etc/sysconfig/network-scripts/ifcfg-ens33
        echo "DNS1=202.106.0.20" >>/etc/sysconfig/network-scripts/ifcfg-ens33

fi

systemctl restart network
echo "七、CentOS系统初始化脚本已全部执行完毕，请检查！"

