#!/bin/sh
# time: 2019-05-08
# this scripts is about how go to select code version
# author: HotXia


[ -f /tmp/code_version.txt ] && rm -rf /tmp/code_version.txt

echo "\033[33m 可以选择回滚的代码日期为: \033[0m"

echo "--------------------------------------------"
for i in `ls /data/code/|grep develop|awk -F\develop_ '{print $2}'`
do
	echo "   "  $i >>/tmp/code_version.txt
done

line=$(cat /tmp/code_version.txt|wc -l)
expr $line / 2 >/dev/null 2>&1

if [ $? -eq 0 ];then
	line_final=$(echo "$line / 2"|bc)
else
	line_final=$(echo "$line / 3"|bc)
fi
#echo $line_final

echo "第1-----`echo ${line_final}`":
sed -e "1,${line_final}p" /tmp/code_version.txt
line2=$(echo "$line - $line_final"|bc)

echo ""
echo "第`echo ${line2}`-----`echo ${line}`":
sed -e "${line2},${line}p" /tmp/code_version.txt

