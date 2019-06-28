#!/bin/sh
#this is redmine system install scripts
#OS：centos6.8
#author:xiatian

yum -y install libyaml-devel zlib-devel curl-devel openssl-devel httpd-devel apr-devel apr-util-devel gcc ruby-devel gcc-c++ make postgresql-devel ImageMagick-devel sqlite-devel perl-LDAP mod_perl perl-Digest-SHA

rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum install mysql-community-server httpd -y

mysql -uroot -e 'create database redmine character set utf8;'
mysql -uroot -e ''redmine'@'localhost' identified by 'redmine';'
mysql -uroot -e 'grant all privileges on redmine.* to 'redmine'@'localhost';'
mysql -uroot -e 'flush privileges;'
   

yum -y install php php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc php-pecl-apc php-soap

\curl -L https://get.rvm.io | bash
source /etc/profile.d/rvm.sh

rvm install '2.4.2'
yum -y install rubygems

gem install passenger
passenger-install-apache2-module

cat >>/etc/httpd/conf.d/passenger.conf <<EOF
LoadModule passenger_module /usr/local/rvm/gems/ruby-2.4.2/gems/passenger-5.1.8/buildout/apache2/mod_passenger.so
  <IfModule mod_passenger.c>
    PassengerRoot /usr/local/rvm/gems/ruby-2.4.2/gems/passenger-5.1.8
    PassengerDefaultRuby /usr/local/rvm/gems/ruby-2.4.2/wrappers/ruby
  </IfModule>
EOF

mkdir -p /data 
wget http://www.redmine.org/releases/redmine-3.4.6.tar.gz
tar -zxvf redmine-3.4.6.tar.gz
mv redmine-3.4.6 /data

cat >> /etc/http/conf.d/redmine.conf <<EOF
<VirtualHost *:80>
      ServerName
      # !!! Be sure to point DocumentRoot to 'public'!
     DocumentRoot /data/redmine-3.4.6/public
      ErrorLog logs/redmine_error_log
      <Directory /data/redmine-3.4.6/public>
        Options Indexes ExecCGI FollowSymLinks
        Order allow,deny
        Allow from all
        # This relaxes Apache security settings.
        AllowOverride all
        # MultiViews must be turned off.
        Options -MultiViews
        # Uncomment this if you're on Apache >= 2.4:
        #Require all granted  
      </Directory>
  </VirtualHost>
EOF
service httpd restart

cd /data/redmine-3.4.6/config
cp database.yml.example database.yml

cat >> database.yml <<EOF
production:
  adapter: mysql2
  database: redmine
  host: localhost
  username: redmine
  password: "redmine"
  encoding: utf8
EOF

yum install mysql-devel -y 
cd /data/redmine-3.4.6
gem install bundler
bundle install 

rake generate_secret_token

rake db:migrate RAILS_ENV=production

cd /data/redmine-3.4.2/public
mkdir plugin_assets
cp dispatch.fcgi.example dispatch.fcgi
cp htaccess.fcgi.example htaccess.fcg


rpm --import https://Fedoraproject.org/static/0608B895.txt
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum -y install mod_fcgid


mkdir -p /data/redmine-3.4.6/files
cd /data/redmine-3.4.6/config
cp configuration.yml.example configuration.yml

cd /data
chown -R apache:apache redmine-3.4.6
chmod -R 755 redmine-3.4.6
service httpd restart






































