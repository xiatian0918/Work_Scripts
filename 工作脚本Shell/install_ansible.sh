#!/bin/sh
#author:xiatian

ip_list=$1
user=$2
passwd=$3

yum install ansible -y
yum install -y python-pip
pip install requests
pip install pywinrm
cp /etc/ansible/hosts{,.bak}
cat /dev/null >/etc/ansible/hosts
cat >>/etc/ansible/hosts <<EOF
[windows]
$ip_list ansible_ssh_user="$user" ansible_ssh_pass="$passwd" ansible_ssh_port=5985 ansible_connection="winrm" ansible_winrm_server_cert_validation=ignore
EOF

echo "test connect ansible"
a=`ansible windows -m win_ping`
[ $a -eq 0 ] && echo "test ok!" || echo "sorry,test failed"

