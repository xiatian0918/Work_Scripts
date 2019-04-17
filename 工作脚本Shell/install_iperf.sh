#!/bin/sh
#author:xiatian

cd /usr/local/src/
wget http://*******.62/tools/iperf-3.1.3-source.tar.gz
tar -zxf iperf-3.1.3-source.tar.gz
cd iperf-3.1.3
./configure
make && make install
ln -s /usr/local/bin/iperf3 /usr/bin/iperf3
