#!/bin/sh
#ubuntu source.list
#author:xiatian


# 配置ubuntu系统下载源
echo -e "\033[47;34m 1.Configure system source \033[0m"
echo ""
read -p "Please confirm whether the system source needs to be configured (Y|N): " value_source
if [ "$value_source" == "Y" ];then
	rm -rf /var/lib/dpkg/lock;rm -rf /var/lib/apt/lists/lock
#	sudo apt-get clean
	\cp /etc/apt/sources.list /etc/apt/sources.list.bak
	sudo cat /dev/null >/etc/apt/sources.list
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse" >>/etc/apt/sources.list
	sudo apt-get update
fi

# 创建用户
useradd tgc

# 创建项目工作目录
[ ! -d "/home/tgc/Desktop/" ] && mkdir -p /home/tgc/Desktop/

# 安装基础web依赖包
echo -e "\033[47;34m 2.Install base package \033[0m"
echo ""
sudo rm -rf /var/lib/dpkg/lock;sudo rm -rf /var/lib/apt/lists/lock
sudo apt-get update
apt-get install -y lrzsz build-essential libtool libpcre3 libpcre3-dev  zlib1g-dev openssl openssl-devel nginx
apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev  \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev


# 安装ubuntu系统下Python-3.6.7版本
echo -e "\033[47;34m 3.Install Python 3.6.7 \033[0m"
echo ""
wget http://218.241.213.228/tools/docker/Python-3.6.7.tar.xz
xz -d Python-3.6.7.tar.xz
tar xf Python-3.6.7.tar
mv Python-3.6.7 /usr/local
cd /usr/local/Python-3.6.7
./configure --with-ssl
sudo make
sudo make install
sudo ln -s /usr/local/bin/python3.6 /usr/bin/python3.6
sudo ln -s /usr/local/bin/pip3 /usr/bin/pip3.6
pip3.6 install uwsgi -i https://pypi.tuna.tsinghua.edu.cn/simple
wget http://218.241.213.228/tools/docker/requirements.txt
mv requirements.txt /usr/local/src/
pip3.6 install -r /usr/local/src/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 解压项目工程到指定目录并授权
echo -e "\033[47;34m 4.Upload Django project \033[0m"
echo ""
wget http://218.241.213.228/tools/docker/web_code.zip
unzip web_code.zip
\cp -r home/cuipeng/Desktop/toprs_copy /home/tgc/Desktop/
chown -R tgc.tgc /home/tgc/*
chmod -R 777 /home/tgc/*

# 获取服务配置信息
echo -e "\033[47;34m 5.Enter the cloud platform service IP address \033[0m"
echo ""
read  -p "please input your mysql address: " mysql_ip
[ -z $mysql_ip ] && {
	echo lease enter the correct parameters
	exit 2
}

read -p "please input your images proxy address: " images_ip
[ -z $images_ip ] && {
        echo lease enter the correct parameters
        exit 2
}

read -p "please input your mongodb address: " mongodb_ip
[ -z $mongodb_ip ] && {
        echo lease enter the correct parameters
        exit 2
}

read -p "please input your redis address: " redis_ip
[ -z $redis_ip ] && {
        echo lease enter the correct parameters
        exit 2
}

# 修改云平台服务配置IP地址
echo -e "\033[47;34m 6.Configure the service IP address in Django \033[0m"
echo ""
/bin/sed -i "123s#192.168.254.129#$mysql_ip#" /home/tgc/Desktop/toprs_copy/Toprs/topr/toprs/settings/dev.py
/bin/sed -i "392s#192.168.254.128#$mongodb_ip#" /home/tgc/Desktop/toprs_copy/Toprs/topr/toprs/settings/dev.py
/bin/sed -i "331s#192.168.254.129#$images_ip#" /home/tgc/Desktop/toprs_copy/Toprs/topr/toprs/settings/dev.py
/bin/sed -i "s#192.168.254.128:6379#"$redis_ip":6379#g" /home/tgc/Desktop/toprs_copy/Toprs/topr/toprs/settings/dev.py


# 修改UWSGI服务配置文件中的路径
/bin/sed -i 's#/home/cuipeng/Desktop/toprs_copy/Toprs/topr/#/home/tgc/Desktop/toprs_copy/Toprs/topr/#' /home/tgc/Desktop/toprs_copy/Toprs/topr/toprs.xml

# 配置NGINX服务
echo -e "\033[47;34m 7.Install and configure nginx \033[0m"
echo ""
apt-get install -y nginx
ip_address=$(ifconfig|grep ens -C3|grep "inet addr"|cut -d':' -f2|awk '{print $1}')
wget http://218.241.213.228/tools/docker/nginx.conf
\cp nginx.conf /etc/nginx/nginx.conf
sed -i "s#192.168.0.61#"$ip_address"#" /etc/nginx/nginx.conf
sed -i 's#/home/xiatian/PycharmProjects/develop/Toprs/topr#/home/tgc/Desktop/toprs_copy/Toprs/topr#g' /etc/nginx/nginx.conf
sed -i 's#user xiatian#user tgc#' /etc/nginx/nginx.conf
mkdir -p /data/log/nginx/
chmod -R 777 /data/*
nginx -t

echo -e "\033[47;34m 8.Start all services and verify success \033[0m"
echo ""
# 启动Django项目服务
nohup python3.6 /home/tgc/Desktop/toprs_copy/Toprs/topr/manage.py runserver &

# 启动UWSGI服务
uwsgi -x /home/tgc/Desktop/toprs_copy/Toprs/topr/toprs.xml

# 启动NGINX服务
nginx 
nginx -s reload

# 查看服务端口
netstat -tlnp|egrep "8997|8000|80"

# 验证云平台主页访问状态码
curl -sI http://$ip_address|grep "HTTP"
