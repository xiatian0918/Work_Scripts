#!/bin/sh
# 这是一个获取全国地区请求人数的脚本
# author:xiatian

cat /mnt/system/haproxy_log/haproxy.log|awk '{print $8}'|awk -F\: '{print $1}'|sort|uniq >/data/log/num_people.txt

cat /data/log/num_people.txt|while read line;
do	
	diqu=$(curl -s http://www.cip.cc/$line|sed -n '2p'|awk -F\: '{print $2}')
	echo $diqu >>/mnt/monitor_data/total_map/num.txt
done


cat /mnt/monitor_data/total_map/num.txt|grep "中国" > /mnt/monitor_data/total_map/china_num.txt
cat /mnt/monitor_data/total_map/china_num.txt|sort |uniq -c|awk '{$2=substr($2,3,6);print}'> /mnt/monitor_data/total_map/user_number_new.txt
cat /mnt/monitor_data/total_map/user_number_new.txt|awk '{print $1,$2}' > /mnt/monitor_data/total_map/user_number.txt
sed -i 's# #  #g' /mnt/monitor_data/total_map/user_number.txt
iconv -c -f utf-8 -t utf-8 /mnt/monitor_data/total_map/user_number.txt
\rm -rf /mnt/monitor_data/total_map/num.txt /mnt/monitor_data/total_map/china_num.txt /mnt/monitor_data/total_map/user_number_new.txt

