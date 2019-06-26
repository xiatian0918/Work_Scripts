#!/bin/sh

shaixuan=$1

file_name=/root/2222.txt

sed -i 's#：#:#g' $file_name
file_filter="doc|docx|xls|xslx" #filter the file ,use "|" split
#C盘过滤
for s in `cat $file_name |grep -E $file_filter|awk '{print $1}'|awk -F\20 '{print $1}'`;do
	dir_name=$(cat $file_name |grep -E "$s"|grep C:|awk '{print $2}'|sed -e 's#$#\\#g'|sed -e 's$\\$\\\\$g')
	a=$(echo $dir_name|sed -e 's$\\$\\\\$g')
	echo $a >> 333.txt
done
for i in `cat $file_name|egrep "doc|docx|xls|xlsx"|awk '{print $NF}'`;do
	echo $i|sed -e "s/^/"$a"/" >>resault.txt
	echo $i >> 444.txt
done
row1=`cat 333.txt|wc -l`
j=1
while(($j <= $row1))
do
#    echo "$j $row1"
    confile1=`sed -n ''$j'p' 333.txt`
    confile2=`sed -n ''$j'p' 444.txt`
    echo ${confile1}${confile2}>>555.txt
    j=$(($j+1))
done

rm -rf 333.txt 444.txt 555.txt
cat resault.txt
