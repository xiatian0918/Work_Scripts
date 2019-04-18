#!/bin/sh

yum update -y
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker

wget https://github.com/git/git/archive/v2.7.4.zip
unzip v2.7.4.zip
cd git-2.7.4

make prefix=/usr/local/git all
make prefix=/usr/local/git install
rm -rf /usr/bin/git
ln -s /usr/local/git/bin/git /usr/bin/git
git --version
