#!/bin/sh
# time:2019-05-27
# author:xiatian
# 获取保密自检结果中的文件信息

cd /data/www/研发三部保密情况检查/

for i in `ls ./`;
do 
	
	for s in `ls $i/*`;do curl -s "http://192.168.0.62/研发三部保密情况检查/$s"|egrep 'docx|xls'|grep -v "常规检查" &>> /tmp/保密结果检查.txt;done

done
