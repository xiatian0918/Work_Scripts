#!/bin/sh

cd /var/log/nginx/ && rsync -artuz -R --delete ./ 192.168.0.62::web
