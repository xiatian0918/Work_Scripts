#!/bin/sh
#author:xiatian

mkdir -p /tmp/local

for j in {write,randwrite,read,randread};do
	rm -rf /data/1.txt && touch /data/1.txt
	for num in {4,8,16};do
	fio -filename=/data/1.txt -direct=1 -iodepth=128 -thread -rw=$j -ioengine=libaio -bs=1M -size=10G -numjobs=$num -runtime=300 -group_reporting -name=toprs &> /tmp/local/"$j"_fio_"$num".txt
	done
done

