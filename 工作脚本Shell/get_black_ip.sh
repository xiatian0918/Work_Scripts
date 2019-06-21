#!/bin/sh
# Time:2019-05-06
# Author:HotXia

url_php=$(cat /data/log/nginx/toprs_access.log |awk '{print $7}'|egrep "php$")
for i in `echo ${url_php}`
do
	cat /data/log/nginx/toprs_access.log|egrep "$i"|awk '{print $1}' >>/tmp/black_ip.list
done

#black_ip=$(cat /tmp/black_ip.list|sort |uniq -c)
#rm -rf /tmp/black_ip.list

#cat /tmp/black_ip.list|sort |uniq -c|awk '{print $2}'

cp /usr/local/nginx/conf.d/denyips.conf{,_`date +"%Y-%m-%d"`}

for k in `cat /tmp/black_ip.list|sort |uniq -c|awk '{print $2}'`
do
	echo deny "$k"\; >>/usr/local/nginx/conf.d/denyips.conf
done

/usr/local/nginx/sbin/nginx -s reload
rm -rf /tmp/black_ip.list
