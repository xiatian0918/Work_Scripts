#!/bin/sh
#author: HotXia

#state=$(mysql -h 192.168.0.52 -uroot -p123456789 -e 'show slave status\G'|egrep "Slave_IO_Running|Slave_SQL_Running"|grep -v "Slave_SQL_Running_State"|cut -d':' -f2)


a=$(mysql -h 192.168.0.52 -uroot -p123456789 -e 'show slave status\G'|egrep "Slave_IO_Running"|cut -d':' -f2|cut -d' ' -f2)
b=$(mysql -h 192.168.0.52 -uroot -p123456789 -e 'show slave status\G'|egrep "Slave_SQL_Running"|grep -v "Slave_SQL_Running_State"|cut -d':' -f2|cut -d' ' -f2)

c="Yes"

if [ "$a" != "Yes" ] || [ "$b" != "Yes" ];then
	echo "当前MySQL主从同步出现异常"|mail -s "MySQL主从异常告警" "2831315100@qq.com,18810434724@163.com"
fi

