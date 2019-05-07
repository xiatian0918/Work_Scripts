#!/bin/sh
cd /data/www/ && rsync -artuz -R --delete ./ 192.168.0.62::bakup
