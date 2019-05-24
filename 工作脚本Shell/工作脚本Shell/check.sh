#!/bin/sh

echo "##################################分布式nfs#######################################################"
for i in {8,4,16};do
	cd /tmp/fio
        a1=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '1p'`
        a2=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '2p'`
        a3=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '3p'`
        a4=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '4p'`
        b1=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '1p'`
        b2=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '2p'`
        b3=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '3p'`
        b4=`cat write_fio_"$i".txt randwrite_fio_"$i".txt read_fio_"$i".txt randread_fio_"$i".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '4p'`
	echo "名称: 分布式文件系统顺序写  线程：$i  bw: $a1 	IOPS: $b1"
	echo "名称: 分布式文件系统随机写  线程：$i  bw: $a2 	IOPS: $b2"
	echo "名称: 分布式文件系统顺序读  线程：$i  bw: $a3 	IOPS: $b3"
	echo "名称: 分布式文件系统随机读  线程：$i  bw: $a4 	IOPS: $b4"
done

echo "#######################本地块设备结果#############################################################"

for j in {8,4,16};do
	cd /tmp/local
        c1=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '1p'`
        c2=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '2p'`
        c3=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '3p'`
        c4=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f1|sed -n '4p'`
        d1=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '1p'`
        d2=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '2p'`
        d3=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '3p'`
        d4=`cat write_fio_"$j".txt randwrite_fio_"$j".txt read_fio_"$j".txt randread_fio_"$j".txt |egrep -i "bw=|iops"|cut -d, -f2,3|cut -d, -f2|sed -n '4p'`
	echo "名称: 分布式文件系统顺序写  线程：$j  bw: $c1 	IOPS: $d1"
	echo "名称: 分布式文件系统随机写  线程：$j  bw: $c2 	IOPS: $d2"
	echo "名称: 分布式文件系统顺序读  线程：$j  bw: $c3 	IOPS: $d3"
	echo "名称: 分布式文件系统随机读  线程：$j  bw: $c4 	IOPS: $d4"
done
