#!/bin/sh

for i in `cat /tmp/ip.list`;do echo $i;ssh $i "sh /root/check_linux_ip_mac.sh";echo "";done


