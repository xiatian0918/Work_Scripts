#!/bin/bash

yum -y install openssl
yum -y install lrzsz telnet* net-snmp-utils net-snmp gcc* man -y
yum -y install libgcrypt-devel lrzsz perl-DBI perl-libwww-perl net-snmp-perl  openssl-devel pcre-devel telnet  nfs-utils rpcbind -y
yum -y install libxml*
mkdir /data/logs/nginx
mkdir /data/package/
cd /data/package
wget -N http://211.103.207.119:81/nginx-1.13.3.tar.gz
#wget -N http://211.103.207.119:81/nginx-1.10.2.tar.gz
wget -N http://211.103.207.119:81/pcre-8.33.tar.gz

cd /usr/local/src
wget -N http://211.103.207.119:81/nginx-rtmp-module-master.zip 
unzip nginx-rtmp-module-master.zip

cd /data/package
tar zxvf pcre-8.33.tar.gz
cd /data/package/pcre-8.33
./configure --prefix=/usr/local/pcre
make && make install

cd /data/package
tar zxvf nginx-1.13.3.tar.gz
cd nginx-1.13.3
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_realip_module --with-http_stub_status_module --with-http_flv_module --with-http_mp4_module --with-pcre=/data/package/pcre-8.33 --add-module=/usr/local/src/nginx-rtmp-module-master
make && make install

cd /etc/init.d && wget -N http://211.103.207.119:81/nginx/nginx && chmod +x nginx

cd /usr/local/nginx/conf/ && mv nginx.conf nginx.conf.bak && wget -N  http://211.103.207.119:81/nginx/nginx.conf

#service nginx start

/usr/local/nginx/sbin/nginx
#   ps aux|grep nginx 
