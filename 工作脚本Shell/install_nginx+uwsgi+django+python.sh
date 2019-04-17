#!/bin/sh
#this is install service django develop web
#author xiatian
#OS:Centos 7

rpm -ivh https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
systemctl s******* firewalld
setenforce 0

yum -y groupinstall "Development tools"
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel -y

cd /usr/local
wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
tar zxf Python-3.6.6.tgz
cd Python-3.6.6
./configure --prefix=/usr/local/python3
make && make install
ln -s /usr/local/python3/bin/python3.6 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3.6 /usr/bin/pip3
python3 -V
pip3 -V
pip3 install virtualenv
ln -s /usr/local/python3/bin/virtualenv /usr/bin/virtualenv

mkdir -pv /data/{env,wwwroot}
cd /data/env/
virtualenv --python=/usr/bin/python3 pyweb
cd /data/env/pyweb/bin
source activate

pip3 install django
pip3 install uwsgi
ln -s /usr/local/python3/bin/uwsgi /usr/bin/uwsgi

echo "请上传你的项目打包文件，请以zip压缩文件类型打包项目文件！" 
python3 manage.py runserver

cd /data/wwwroot/yourproject/
cat >>yourproject.xml<<EOF
<uwsgi>    
   <socket>127.0.0.1:8997</socket><!-- 内部端口，自定义 --> 
   <chdir>/data/wwwroot/yourproject/</chdir><!-- 项目路径 -->            
   <module>yourproject.wsgi</module> 
   <processes>4</processes> <!-- 进程数 -->     
   <daemonize>uwsgi.log</daemonize><!-- 日志文件 -->
</uwsgi>
EOF

cd /usr/local/src 
wget http://nginx.org/download/nginx-1.13.7.tar.gz
tar zxf nginx-1.13.7.tar.gz
cd nginx-1.13.7
./configure
make && make install

mv /usr/local/nginx/conf/nginx.conf{,.bak}
mkdir -p /var/log/nginx 
cat >>/usr/local/nginx/conf/nginx.conf<<EOF
worker_processes  1;
error_log  /var/log/nginx/error.log;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    server {
        listen       80;
        server_name  www.django.cn;
        charset utf-8;
        location / {
           include uwsgi_params;
           uwsgi_pass 127.0.0.1:8997;  #端口要和uwsgi里配置的一样
           uwsgi_param UWSGI_SCRIPT yourproject.wsgi;  #wsgi.py所在的目录名+.wsgi
           uwsgi_param UWSGI_CHDIR /data/wwwroot/yourproject; #项目路径
           
        }
        location /static/ {
        alias data/wwwroot/yourproject/static/; #静态资源路径
        }
    }
}
EOF

/usr/local/nginx/sbin/nginx -t 
/usr/local/nginx/sbin/nginx

cd /data/wwwroot/yourproject/
uwsgi -x yourproject.xml

/usr/local/nginx/sbin/nginx -s reload

netstat -tlnp|egrep "uwsgi|nginx"
