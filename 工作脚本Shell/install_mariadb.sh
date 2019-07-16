#!/bin/sh
# 时间:2019-06-27
# 编写人:夏天
# 描述:此脚本是CentOS 7系统下安装部署MariaDB数据库

yum install -y mariadb mariadb-server

# 初始化MariaDB数据库
mysql_secure_installation
