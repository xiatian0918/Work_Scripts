#!/bin/sh
# 时间：2019-07-12
# 编写人：夏天
# 描述：此脚本是自动化部署配置TGC前端访问站点

cd /usr/local/src/
wget -c http://218.241.213.228/tools/web-images.tar.gz
wget -c http://218.241.213.228/tools/tgc-web.tar.gz

docker load < /usr/local/src/tools/web-images.tar.gz
docker load < /usr/local/src/tools/tgc-web.tar.gz

docker run -it -d --name=tgc-images -p 8080:80 hotxia/web_images supervisord
docker run -it -d --name=web -p 80:80 hotxia/tgc-web supervisord
