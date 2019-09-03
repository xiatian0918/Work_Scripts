#!/bin/sh


cd /mnt/system/show_dhcp
cat out.txt|grep "^[0-9]"|awk -F\-D '{print $1}'
