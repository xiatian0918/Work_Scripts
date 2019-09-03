#!/bin/sh
# 时间：2019-08-30
# 编写人：夏天
# 描述：此脚本是在centreon监控系统下如何监控API的状态


code=$(curl -H Content-Type:application/json -s -XPOST http://192.168.0.61/user/login/ -d '{"username":"测试001","password":"123456"}'|jq .|grep code|cut -d':' -f2|awk -F\" '{print $2}')

if [ $code -eq 0 ];then
	echo "API Login Success"
	exit 0
elif [ $code -ne 0 ];then
	echo "API Login Failed"
	exit 2
fi

