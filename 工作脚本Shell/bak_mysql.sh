#!/bin/sh


date_time=$(date +%Y%m%d)

mysqldump -h 192.168.0.53 -uroot -p'123456789' toprs >/mnt/system/mysql_slow_log/bak_mysql/web_toprs_"$date_time".sql

gzip /mnt/system/mysql_slow_log/bak_mysql/web_toprs_"$date_time".sql
