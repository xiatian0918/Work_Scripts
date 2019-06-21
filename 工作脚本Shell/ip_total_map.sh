#!/bin/sh
# 这是一个获取全国地区请求人数的脚本
# author:xiatian

/usr/bin/cat /data/log/nginx/toprs_access.log |awk '{print $1}'|sort |uniq -c >/data/log/num_people.txt

cat /data/log/num_people.txt|while read line;
do	
	diqu=$(curl -s http://www.cip.cc/`echo $line |awk '{print $2}'`|sed -n '2p'|awk -F\: '{print $2}')
	renshu=$(echo $line|awk '{print $1}')
	echo $diqu $renshu >>/mnt/monitor_data/total_map/num.txt
done


cat /mnt/monitor_data/total_map/num.txt |sort |uniq -c|grep "中国"|awk '{$2=substr($2,3,6);print}' >/mnt/monitor_data/total_map/china_num.txt

cat /mnt/monitor_data/total_map/china_num.txt|awk '{print $1}' >/mnt/monitor_data/total_map/lie_1.txt
cat /mnt/monitor_data/total_map/china_num.txt|awk '{print $NF}' >/mnt/monitor_data/total_map/lie_final.txt

 
F1="/mnt/monitor_data/total_map/lie_1.txt"
F2="/mnt/monitor_data/total_map/lie_final.txt"
NUM=1
 
while read F1_NUM
do
 
        F2_NUM=`awk NR==$NUM $F2`
        NUM=$[$NUM+1]
        echo "result:$[$F1_NUM*$F2_NUM]"|awk -F\: '{print $2}' >>/mnt/monitor_data/total_map/resault.txt
 
done < $F1

cat /mnt/monitor_data/total_map/num.txt |sort |uniq -c|grep "中国"|awk '{$2=substr($2,3,6);print}'|awk '{print $(int(NF/2)+1) }' >/mnt/monitor_data/total_map/name_map.txt


awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' /mnt/monitor_data/total_map/name_map.txt /mnt/monitor_data/total_map/resault.txt >/mnt/monitor_data/total_map/web_uv.txt

\rm -rf /mnt/monitor_data/total_map/lie_final.txt /mnt/monitor_data/total_map/lie_1.txt /mnt/monitor_data/total_map/china_num.txt /mnt/monitor_data/total_map/name_map.txt /mnt/monitor_data/total_map/resault.txt  

awk '{sum[$1]+=$2}END{for(c in sum){print c,sum[c]}}' /mnt/monitor_data/total_map/web_uv.txt >/mnt/monitor_data/total_map/user_number.txt

\rm -rf /mnt/monitor_data/total_map/web_uv.txt
