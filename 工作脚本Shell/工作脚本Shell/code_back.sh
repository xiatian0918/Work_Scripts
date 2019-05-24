#!/bin/sh
# time: 2019-05-08
# this scripts is about how go to select code version
# author: HotXia

#/bin/sh /root/code_show.sh

code_date="$1"

#read -p "请选择你要回滚的代码日期: " code_date
if [ -z $code_date ];then
	echo "请输入正确的回滚代码的日期,正在退出中...."
	exit 1
fi

rm -rf /home/xiatian/PycharmProjects/develop

ln -sv /data/code/develop_$code_date /home/xiatian/PycharmProjects/develop
chown -R xiatian:xiatian /home/xiatian/PycharmProjects/develop

/bin/sh /root/res_django_service.sh
