#!/bin/bash
# 描述：OpenStack重启虚拟机电源

source /root/demo-openstack.sh
. /root/demo-openstack.sh

SERVER=$1
openstack server reboot $SERVER
