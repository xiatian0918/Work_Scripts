#!/bin/sh
# 时间: 2019-05-28
# 作者: 夏天
# 描述: 这个脚本是获取通过名字查询到有哪些文档包括涉密字样

name=$1

#[ ! -d "/mnt/system/check/$1" ] && mkdir -p /mnt/system/check/$1

[ -f /tmp/"$1"_保密结果检查.txt ] && \rm -rf /tmp/"$1"_保密结果检查.txt
cd /data/www/研发三部保密情况检查/

dir_name=$(ls -d "$1"*)

echo $dir_name

for i in `ls "$1"*/`;
do 

	curl -s "http://192.168.0.62/研发三部保密情况检查/${dir_name}/$i" |egrep 'ppt|pdf|doc|docx|xlsx'|grep -v "常规检查" |grep -v script &>> /tmp/"$1"_保密结果检查.txt

done

cat /tmp/"$1"_保密结果检查.txt|awk -F\, '{print $4,$5}'|sed 's#"##g'|awk '{$NF="";print}'>/mnt/system/check/"$1"_结果.txt

