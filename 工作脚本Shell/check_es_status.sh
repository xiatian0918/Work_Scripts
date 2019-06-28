#!/bin/sh
#时间：2019-06-05
#作者：夏天
#描述：这个脚本是检查elasticsearch集群健康状态脚本


# 通过Centreon服务检查elasticsearch节点健康状态
color=$(ssh 192.168.0.64 '/usr/lib/nagios/plugins/check_elasticsearch.sh 192.168.0.54'|awk '{print $5}')

# 判断集群状态颜色，判断如果不是正常颜色，则执行重启服务elasticsearch并且重启logstash服务
if [ $color != "green" ];
then
	ssh 192.168.0.54 "systemctl restart elasticsearch;kill -9 `ps aux|grep logstash|grep -v grep|awk '{print $2}'`; \
	nohup /usr/share/logstash/bin/logstash -f /opt/nginx.conf &>/tmp/logstash.log &"
	ssh 192.168.0.54 "systemctl restart elasticsearch"
fi

