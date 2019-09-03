#!/bin/sh


dir_name=$1
base_name=$(echo $dir_name |awk -F\\ '{print $NF}')

ls -l /mnt/development/upload/ >/tmp/1.txt

cat /tmp/1.txt|grep -v "^总用"|awk '{print $8}' >/tmp/2.txt
cat /tmp/2.txt |while read i;do echo $i|cut -d':' -f2 >>/tmp/3.txt;done

num1=$(cat /tmp/3.txt |tail -1)
num2=$(cat /tmp/3.txt |tail -2|grep -v `cat /tmp/3.txt |tail -1`)

resault=`echo "$num1 > $num2" |bc`

if [ $resault -eq 1 ];then
	num3=$(cat /tmp/1.txt|egrep $num1|tail -1|awk '{print $NF}')
	cd /mnt/development/upload && mv $num3 $base_name
else
	num4=$(cat /tmp/1.txt|egrep $num2|tail -1|awk '{print $NF}')
	cd /mnt/development/upload && mv $num4 $base_name
fi

rm -rf /tmp/*.txt

	
