#!/bin/sh
rpm -ivh http://*******.62/tools/libaio-devel-0.3.107-10.el6.i686.rpm
rpm -ivh http://*******.62/tools/fio-2.2.8-2.el7.x86_64.rpm
yum install libaio-devel -y
cd /usr/local/src/
wget http://*******.62/tools/fio-2.0.7.tar.gz
tar -zxf fio-2.0.7.tar.gz
cd fio-2.0.7
make && make install
