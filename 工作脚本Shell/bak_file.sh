#!/bin/sh
# 时间: 2019-05-28
# 作者: 夏天
# 描述: 这个脚本是把保密检查出来的文件自动保存到共享存储中

name=$1

[ ! -d "/mnt/monitor_data/bak_bm_file/$1" ] && mkdir -p /mnt/monitor_data/bak_bm_file/$1

[ -f /tmp/"$1"_保密结果检查.txt ] && \rm -rf /tmp/"$1"_保密结果检查.txt
cd /data/www/研发三部保密情况检查/

dir_name=$(ls -d "$1"*)

echo $dir_name

for i in `ls "$1"*/`;
do 

	curl -s "http://192.168.0.62/研发三部保密情况检查/${dir_name}/$i" |egrep 'doc|docx|xls'|grep -v "常规检查" |grep -v script|egrep "合同|投标|招标|招投标" &>> /tmp/"$1"_保密结果检查.txt

done

cat /tmp/"$1"_保密结果检查.txt|awk -F\, '{print $4,$5}'|sed 's#"##g'|awk '{$NF="";print}' >/mnt/monitor_data/bak_bm_file/"$1"_结果.txt

