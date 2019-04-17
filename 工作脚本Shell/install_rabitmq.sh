#!/bin/sh
#install rabitmq
#author:xiatian

yum install erlang -y
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.6/rabbitmq-server-3.6.6-1.el7.noarch.rpm
yum install rabbitmq-server-3.6.6-1.el7.noarch.rpm  -y
service rabbitmq-server start
service rabbitmq-server status

find / -name "rabbitmq.config.example"
cp /usr/share/doc/rabbitmq-server-3.6.6/rabbitmq.config.example /etc/rabbitmq/
cd /etc/rabbitmq/
cp rabbitmq.config.example rabbitmq.config
rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart
rabbitmqctl add_user ******* 123456789
rabbitmqctl set_user_tags ******* *******istrator
rabbitmqctl set_permissions -p "/" ******* ".*" ".*" ".*"
rabbitmqctl list_users
netstat -tlnp|grep 15672
