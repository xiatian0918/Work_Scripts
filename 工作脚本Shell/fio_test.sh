#!/bin/sh
#author:xiatian

fio --help &>/dev/null
if [ $? -ne 0 ];then
	echo "请先安装性能测试工具:fio"
	read -t 5 -p "是否要安装fio工具(yes|no): " tool
	if [ -z $tool ];then
                echo ""
		exit 1
	fi
	e="yes"
	if [ "$tool" = "$e" ];then
		wget http://*******.62/install_shell/install_fio.sh
		/bin/sh install_fio.sh
		ln -s /usr/local/bin/fio /usr/bin/fio
	else
		exit 2
	fi
fi

echo "下面开始检查你所使用的系统是否已挂载nfs文件系统"

a=`df -h|grep *******.29|wc -l`
if [ $a -ne 0 ];then
	echo "你使用系统已挂载nfs "
else
	echo "你所使用系统未挂载nfs"
	read -t 5 -p "是否要挂载nfs文件系统：(yes|no)" file
	if [ -z $file ];then 
		echo ""
		exit 1
	fi
	if [ "$file" = "yes" ];then
		b=`showmount -e *******.29|grep "^/"|awk '{print $1}'`
		for i in `showmount -e *******.29|grep "^/"|awk '{print $1}'`;do mkdir -p $i;	mount -t nfs *******.29:"$i" "$i";done
	else
		exit 3
	fi
fi

echo "下面开始使用fio工具测试性能"

mkdir -p /tmp/fio

for h in `showmount -e *******.29|grep "^/"|awk '{print $1}'`;do rm -rf $h/1.txt;touch $h/1.txt;done
read -t 8 -p "请输入要测试的线程数: " num

expr $num + 0 &>/dev/null
[ $? -ne 0 ] && {
	echo "请输入合法的线程数的值"
	exit 5
}

for j in {write,randwrite,read,randread};do
	for k in `showmount -e *******.29|grep "^/"|awk '{print $1}'`;do rm -rf $h/1.txt;touch $k/1.txt;done
	fio -filename=/sdsfs/*******-rd3-60TB/1.txt:/sdsfs/xiatian-test-1/1.txt:/sdsfs/xiatian-test-2/1.txt -direct=1 -iodepth=128 -thread -rw=$j  -ioengine=libaio -bs=1M -size=10G -numjobs=$num -runtime=300 -group_reporting -name=******* &> /tmp/fio/"$j"_fio_"$num".txt
	x=$(cat /tmp/fio/"$j"_fio_"$num".txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f 2|cut -d= -f2|cut -dK -f1)
	m=$(cat /tmp/fio/"$j"_fio_"$num".txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f 2|cut -d= -f 2|grep M|wc -l)
	if [ $m -eq 0 ];then 
		y=$(echo "scale=2;$x / 1024"|bc)
		z=$(cat /tmp/fio/"$j"_fio_"$num".txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f3|cut -d= -f2)
		echo "测试名称: $j              测试线程数: $num       带宽值为: $y	 IOPS值为：$z"
	else
		n1=$(cat /tmp/fio/*write*.txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f 2|cut -d= -f2|cut -dK -f1|head -1)
		n2=$(cat /tmp/fio/*write*.txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f 2|cut -d= -f2|cut -dK -f1|head -2)
		e1=$(cat /tmp/fio/*write*.txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f3|cut -d= -f2|head -1)
		e2=$(cat /tmp/fio/*write*.txt|grep ******* -A 2|egrep "bw|iops"|cut -d, -f3|cut -d= -f2|head -2)
		k1=$(echo "scale=2;$n1 / 1024"|bc)
		k2=$(echo "scale=2;$n2 / 1024"|bc)
		p1=$(cat /tmp/fio/*read*.txt|grep ******* -A 2|egrep "bw"|cut -d, -f 2|cut -d= -f 2|head -1)
		p2=$(cat /tmp/fio/*read*.txt|grep ******* -A 2|egrep "bw"|cut -d, -f 2|cut -d= -f 2|head -2)
		q1=$(cat /tmp/fio/*read*.txt|grep ******* -A2|egrep "iops"|cut -d, -f 3|cut -d= -f2|head -1)
		q2=$(cat /tmp/fio/*read*.txt|grep ******* -A2|egrep "iops"|cut -d, -f 3|cut -d= -f2|head -1)
		echo "测试名称: write 	       测试线程数: $num      带宽值为: $k2      IOPS值为：$e2"
		echo "测试名称: randwrite      测试线程数: $num      带宽值为: $k1      IOPS值为：$e1"
		echo "测试名称: write          测试线程数: $num      带宽值为: $p2      IOPS值为：$q2"
		echo "测试名称: randwrite      测试线程数: $num      带宽值为: $p1      IOPS值为：$q1"
	fi	

done

rm -rf /tmp/fio/*
