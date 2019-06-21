#!/bin/sh
#this is about uwsgi service start or stop
#author xiatian

case $1 in

status)
	a=`ps aux|grep uwsgi.ini|grep -v grep|wc -l`
	if [ $a -ne 0 ];then
		  echo "当前服务:uwsgi 正在运行中" 
	else
		  echo "服务:uwsgi 已停止运行"
	fi
;;

start)
	/usr/local/bin/uwsgi --ini /djproject/EdmureBlog/uwsgi.ini &>/dev/null
	c=`ps aux|grep uwsgi.ini|grep -v grep|wc -l`
	[ $c -ne 0 ] && echo "服务:uwsgi 启动成功"
;;

stop)
	d=`ps aux|grep uwsgi.ini|grep -v grep|awk '{print $2}'|head -1`
        kill -9 $d
	e=`ps aux|grep uwsgi.ini|grep -v grep|wc -l`
	[ $e -eq 0 ] && echo "服务:uwsgi 已停止服务"
;;

restart)
	f=`ps -ef|grep uwsgi.ini|grep -v grep|awk '{print $2}'|head -1`
        kill -9 $f
	/usr/local/bin/uwsgi --ini /djproject/EdmureBlog/uwsgi.ini &>/dev/null
        g=`ps aux|grep uwsgi.ini|grep -v grep|wc -l`
        [ $g -ne 0 ] && echo "服务:uwsgi 重新启动成功"
;;

*)
	echo "请输入参数，参数可选择(start|status|stop|restart)"
;;

esac
