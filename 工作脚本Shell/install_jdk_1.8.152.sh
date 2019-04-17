#!/bin/bash
cd /usr/local/src/
wget http://*******.62/tools/jdk-8u152-linux-x64.tar.gz
tar -zxvf jdk-8u152-linux-x64.tar.gz
mv jdk1.8.0_152/ /usr/local/
echo "JAVA_HOME=/usr/local/jdk1.8.0_152" >> /etc/profile
echo "PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
echo "CLASSPATH=\$JAVA_HOME/jre/lib/ext:\$JAVA_HOME/lib/tools.jar" >> /etc/profile
echo "export PATH JAVA_HOME CLASSPATH" >> /etc/profile
sleep 2
source /etc/profile
. /etc/profile
