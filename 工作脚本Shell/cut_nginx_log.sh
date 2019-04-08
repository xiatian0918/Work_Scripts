#!/bin/bash
logdir="/var/log/nginx"
yesterday=`date -d "yesterday" "+%Y%m%d"`
mkdir -p $logdir/$yesterday

cd $logdir
for i in $(ls *.log);
do
    mv $i $i.$yesterday;
done 

for j in $(ls *.log.$yesterday);
do
     gzip $j; 
done

mv $logdir/*.log.$yesterday* $logdir/$yesterday > /dev/null 2>&1  #把文件 移动到目录下
