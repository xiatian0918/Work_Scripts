#!/bin/sh
#author:xiatian

for i in 192.168.0.{21..23};
do
	a=$(/usr/bin/snmpwalk -v 2c -c VSJPg7Gpm0Z08hbR $i ifDescr|awk '{print $5,$6,$7}')
  	echo -e "\n$i\n$a\n">>/tmp/inter.txt
done
