#!/bin/sh
# 这是一个删掉共享存储不是目录的脚本

cd /mnt

for i in `/bin/ls -l /mnt/|grep -v "^d"|grep -v "总用量"`;do
	\rm $i
done
