#!/bin/bash
cat <<EOF
-------------num 1 install base package---------------------- 
EOF
yum install libgcrypt-devel lrzsz perl-DBI perl-libwww-perl net-snmp-perl  openssl-devel pcre-devel telnet  nfs-utils rpcbind -y

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

cat <<EOF
-------------num 2 stop iptables with selinux---------------
EOF
sed -i '7 c SELINUX=disabled' /etc/selinux/config
setenforce 0
firewall=`cat /etc/redhat-release |awk '{print $4}'|awk -F "." '{print $1}'`
[ ${firewall} -eq 7 ] && systemctl stop firewalld.service && systemctl disable firewalld.service
#ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime || {
service iptables stop
chkconfig iptables off
}

cat <<EOF
------------num 3 install service--------------------------
EOF

yum update -y glibc*
yum update -y openssh
yum update -y bash
echo " export HISTTIMEFORMAT=\" %Y-%m-%d  %H:%M:%S  \`whoami\`  \" ">>/root/.bashrc
source /root/.bashrc
[ ! -f /usr/sbin/ntpdate ] && yum install ntpdate -y
echo "*/5 * * * * /usr/sbin/ntpdate 182.92.12.11 >/dev/null 2>&1" >>/var/spool/cron/root

cat <<EOF
------------num 4 install saltstack client------------------------
EOF

cat <<EOF
congratulations on the success of your install !
EOF
