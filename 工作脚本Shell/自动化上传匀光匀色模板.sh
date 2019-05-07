#!/bin/sh

dir=/tmp/images

session=$(curl -H Content-Type:application/json -si -XPOST http://api.toprs.cloud.com/user/login/ -d '{"username":"测试001","password":"123456"}'|grep Cookie|grep Set-Cookie|cut -d':' -f2|cut -d';' -f1)

#echo $session

#read -t 20 -p "请输入上传图片的目录: " dir
sleep 1
for i in `ls $dir/*`;do
	curl -H "Cookie:$session" -F "templates=@$i" -sXPOST 'http://api.toprs.cloud.com/data/photo/?project_id=2'|jq .
done
