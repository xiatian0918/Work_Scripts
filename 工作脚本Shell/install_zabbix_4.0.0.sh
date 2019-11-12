#!/bin/sh
# 时间：2019-06-20
# 编写人：xiatian
# 描述：这个脚本是安装Zabbix-4.0版本的脚本

yum -y update
yum install -y httpd mariadb-server mariadb php php-mysql php-gd \
libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mhash

rpm -qa httpd php mariadb  

vim /etc/httpd/conf/httpd.conf
	ServerName 192.168.79.154
	DirectoryIndex index.html index.php
	
vim /etc/php.ini
	date.timezone = PRC
	
systemctl start httpd
systemctl enable httpd
systemctl start mariadb
systemctl enable mariadb

ss -anplt | grep httpd
ss -naplt | grep mysql

vim /var/www/html/index.php
	<?php
	phpinfo()
	?>
	
curl http://127.0.0.1 -I  

mysqladmin -u root password 123456789
mysql -uroot -p'123456789'

CREATE DATABASE zabbix character set utf8 collate utf8_bin;
GRANT all ON zabbix.* TO 'zabbix'@'%' IDENTIFIED BY '123456789';
flush privileges;
quit     

vim /var/www/html/index.php 
<?php
$link=mysql_connect('192.168.79.154','zabbix','123456789'); 
if($link) echo "<h1>Success!!</h1>";   #显示Success表示连接数据库成功
 else echo "Fail!!";
mysql_close();
?>
	
mysql -u root -p'123456789'

	select user,host from mysql.user;
	drop user ''@localhost;
	
yum -y install net-snmp net-snmp-devel curl curl-devel libxml2 libxml2-devel \
libevent-devel.x86_64 javacc.noarch  javacc-javadoc.noarch javacc-maven-plugin.noarch javacc*

yum install php-bcmath php-mbstring -y
rpm -ivh http://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
yum install zabbix-server-mysql zabbix-web-mysql -y
zcat /usr/share/doc/zabbix-server-mysql-4.0.9/create.sql.gz | mysql -uzabbix -p'123456789' -h 192.168.79.154 zabbix

vim  /etc/zabbix/zabbix_server.conf 
	[root@linux-node1 ~]# cat /etc/zabbix/zabbix_server.conf |grep -v "^#"|grep '^[a-Z]'
	LogFile=/var/log/zabbix/zabbix_server.log
	LogFileSize=0
	PidFile=/var/run/zabbix/zabbix_server.pid
	SocketDir=/var/run/zabbix
	DBName=zabbix
	DBUser=zabbix
	DBPassword= 123456789
	SNMPTrapperFile=/var/log/snmptrap/snmptrap.log
	Timeout=4
	AlertScriptsPath=/usr/lib/zabbix/alertscripts
	ExternalScripts=/usr/lib/zabbix/externalscripts
	LogSlowQueries=3000
	
vim /etc/httpd/conf.d/zabbix.conf 
php_value date.timezone Asia/Shanghai

systemctl enable zabbix-server
systemctl start zabbix-server.service 