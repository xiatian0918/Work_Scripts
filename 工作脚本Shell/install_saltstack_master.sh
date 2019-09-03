#!/bin/sh
# 时间：2019-06-19
# 编写人：夏天
# 描述：此脚本是自动化安装部署SaltStack Master脚本

yum install salt-master -y
service salt-master start

for i in `cat /tmp/ip.list`
do
	ssh $i "yum install salt-minion -y"
	ssh $i "echo 'master: 192.168.0.62' >>/etc/salt/minion"
	ssh $i "systemctl start salt-minion"
done

salt-key
sleep 2
salt-key -A
salt "*" test.ping
