#!/bin/sh
#时间：2018-06-06
#编写人：Xiatian
#描述：此脚本是源码包编译安装redis-3.2.6



tar zxvf redis-3.2.6.tar.gz
cd redis-3.2.6
make
mkdir /data/redis6380 -p
cp redis.conf /data/redis6380
cp src/redis-server /data/redis6380

cd /data/redis6380/
grep '^[^$|#;]' redis.conf >redis.conf2

mv redis.conf redis.conf.bak
mv redis.conf2 redis.conf
sed -i 's#6379#6380#g' redis.conf
sed -i 's#daemonize no#daemonize yes#g' redis.conf

./redis-server ./redis.conf

