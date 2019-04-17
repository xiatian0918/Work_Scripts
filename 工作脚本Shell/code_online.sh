#!/bin/sh
# Author: HotXia
# This is develop code on line script


cd /data/code/
\cp develop develop_`date +"%m.%d"` -a
cd /data/code/develop/
git pull git@*******.55:root/develop.git master

rm -rf /home/xiatian/PycharmProjects/develop

/bin/ln -sv /data/code/develop /home/xiatian/PycharmProjects/develop

/bin/kill -9 `lsof -i:8000|awk '{print $2}'|grep -v PID`
/usr/bin/pkill -9 uwsgi
/usr/bin/pkill -9 nginx

cd /home/xiatian/PycharmProjects/develop/*******/*******r/

nohup python3 manage.py runserver >/dev/null 2>&1 &

/bin/sh /root/check_uwsgi.sh start
/usr/sbin/nginx

a=$(ss -tnl|egrep "8000|8997"|wc -l)
if [ $a -eq 2 ];then
	echo "代码上线完成"
fi
