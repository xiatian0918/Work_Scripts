#!/bin/sh
# time:2019-05-21
# author:xiatian

month_now=$(date +'%m')

month_before=$(printf "%02d" `echo "$month_now - 1"|bc`)

cd /data/code/

for i in `/bin/ls develop_2019_${month_before}_*`
do
	name_dir=$(echo $i|grep -v Toprs|cut -d':' -f1)
	/bin/mv ./${name_dir} /mnt/system/code_bakup/
done
