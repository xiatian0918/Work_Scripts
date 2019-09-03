#!/bin/sh

# 描述：这个脚本是检查所有的linux节点系统时间的脚本

for i in `cat /tmp/ip.list`;do echo -n "$i" 时间为: `ssh $i "date"|awk '{print $5}'`;echo "";done 
