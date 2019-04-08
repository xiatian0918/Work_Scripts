#!/bin/sh
# This is install mail server scripts
# author:xiatian

#get yum 
https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm

#install dns
yum install bind -y

#modify profile
[root@localhost ~]# cat /etc/named.conf |egrep -v '^//|^$'
options {
	listen-on port 53 { 192.168.79.129; };	
	allow-query     { any; };
	

[root@localhost ~]# cat /etc/named.rfc1912.zones |egrep -v "^//"

zone "zcxt.com" IN {
	type master;
	file "zcxt.com.zone";
	allow-update { none; };
};

zone "79.168.192.in-addr.arpa" IN {
	type master;
	file "192.168.79.zone";
	allow-update { none; };
};

cd /var/named/
cp -p named.localhost zcxt.com.zone
cp -p named.localhost 192.168.79.zone

[root@localhost named]# cat zcxt.com.zone 
$TTL 1D
@	IN SOA	@ 	root (
					0	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	NS	@
	A	192.168.79.129
	IN MX 5 mail.zcxt.com.
mail 	IN	A 	192.168.79.129


systemctl start named.service
systemctl restart named.service

yum install -y bind-utils

#stop firewalld

systemctl disable firewalld
systemctl stop firewalld

[root@localhost named]# cat /etc/postfix/main.cf |egrep -v "^#|^$"|egrep "in|my"
command_directory = /usr/sbin
myhostname = mail.zcxt.com
mydomain = zcxt.com
myorigin = $mydomain
inet_interfaces = 192.168.79.129,127.0.0.1
inet_protocols = all
mydestination = $myhostname, $mydomain
	 PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
sendmail_path = /usr/sbin/sendmail.postfix
newaliases_path = /usr/bin/newaliases.postfix
mailq_path = /usr/bin/mailq.postfix


systemctl restart postfix.service

#install dovecot service

yum install dovecot -y

[root@localhost named]# cat /etc/dovecot/dovecot.conf |egrep "proto|login"|egrep -v "^#|^$"
protocols = imap pop3 lmtp
login_trusted_networks = 192.168.79.0/24

[root@localhost named]# cat /etc/dovecot/conf.d/10-mail.conf |grep "mail_location"|egrep -v "^#|#"
     mail_location = maildir:~/Maildir

#start dovecot service

 systemctl start dovecot.service

systemctl enable postfix.service
systemctl enable named.service
systemctl enable dovecot.service