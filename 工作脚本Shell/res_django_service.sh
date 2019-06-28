#!/bin/sh
# Author HotXia
# this is restart service about django web projects


/usr/bin/lsof -i:8000 &>/dev/null
[ $? -eq 0 ] && /bin/kill -9 `lsof -i:8000|awk '/TCP/{print $2}'`

nohup /usr/bin/python3 /home/xiatian/PycharmProjects/develop/Toprs/topr/manage.py runserver >/dev/null 2>&1 &
if [ $? -ne 0 ];then
	/usr/local/bin/pip3 install django==1.11.1
	/usr/local/bin/pip3 install pymysql
	/usr/local/bin/pip3 install django-crontab
	/usr/local/bin/pip3 install django-cors-headers
	/usr/local/bin/pip3 install itsdangerous
	/usr/local/bin/pip3 install chardet
	/usr/local/bin/pip3 install djangorestframework-jwt
	/usr/local/bin/pip3 install pillow==4.0.0
	/usr/local/bin/pip3 install django_redis
	/usr/local/bin/pip3 install paramiko
	/usr/bin/python3 -m pip install pymongo
	/usr/local/bin/pip3 install pywinrm
else
	echo 时间: `date +"%Y-%m-%d %H:%M:%S"` 服务启动成功 >>/tmp/Python服务每日启动日志.log
fi

/usr/bin/pkill -9 uwsgi
/usr/bin/pkill -9 nginx
/bin/sh /root/check_uwsgi.sh start
/usr/sbin/nginx
