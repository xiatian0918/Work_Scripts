#!/bin/sh

yum -y groupinstall "Development tools"
yum -y install zlib-devel bzip2-devel libffi-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
mkdir /usr/local/python3 -p
cd /opt/
wget http://192.168.0.62/tools/Python-3.7.0.tar.xz
tar xf Python-3.7.0.tar.xz 
cd Python-3.7.0/
./configure --prefix=/usr/local/python3
make && make install
cat >>/etc/profile <<EOF
export PATH=\$PATH:/usr/local/python3/bin
EOF

source /etc/profile
. /etc/profile
export PATH=\$PATH:/usr/local/python3/bin
python3 -V
pip3 -V
