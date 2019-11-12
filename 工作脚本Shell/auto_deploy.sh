#!/bin/sh
# Author: HotXia
# This is develop code on line script



rm -rf /home/xiatian/PycharmProjects/develop
dir_name=$(\ls -l /data/code/|grep -v "uwsgi"|tail -1|awk '{print $NF}')

/bin/ln -sv /data/code/${dir_name} /home/xiatian/PycharmProjects/develop

/bin/kill -9 `lsof -i:8000|awk '{print $2}'|grep -v PID`
/usr/bin/pkill -9 uwsgi
/usr/bin/pkill -9 nginx

cd /home/xiatian/PycharmProjects/develop/Toprs/topr/

nohup python3 manage.py runserver >/dev/null 2>&1 &
echo -n "\\n"

/bin/sh /root/check_uwsgi.sh start
/usr/sbin/nginx
chown -R xiatian:xiatian /data/code/*
chown -R xiatian:xiatian /home/xiatian/PycharmProjects/*

pro_celery=$(ps aux|grep celery|grep -v grep|wc -l)
[ $pro_celery -ne 0 ] && for i in `ps aux|grep celery|grep -v grep |awk '{print $2}'`;do kill -9 $i;done
cd /home/xiatian/PycharmProjects/develop/Toprs/topr 
nohup celery -A celery_tasks.vm_create.tasks worker --loglevel=info --logfile=./logs/celerylog.log &
echo -n "\\n"
echo "现在celery正在启动中..............."
#nohup celery -A celery_tasks.tgc.projectManage worker -l info >/tmp/celery.log 2>&1 &
#celery multi start -A celery_tasks.vm_create.tasks worker -l info >/tmp/celery.log 2>&1

python3.6 /home/xiatian/PycharmProjects/develop/Toprs/topr/manage.py crontab add  &>/dev/null

a=$(ss -tnl|egrep "8000|8997"|wc -l)
if [ $a -eq 2 ];then
	echo "代码上线完成"
fi

python3.6 /home/xiatian/PycharmProjects/develop/Toprs/topr/manage.py crontab add  &>/dev/null

serv_cer=$(ps aux|grep celery |grep -v grep|wc -l)
if [ $serv_cer -eq 0 ];then
	echo "请注意！当前celery服务已经停止运行！"
	exit 6
else
	echo "当前celery服务运行一切正常！"
	exit 3
fi

sleep 5
echo -n "\\n"
