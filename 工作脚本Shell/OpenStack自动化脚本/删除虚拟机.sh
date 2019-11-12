#!/bin/bash
# 描述：OpenStack删除虚拟机


source /root/demo-openstack.sh
. /root/demo-openstack.sh

newserver=$1
openstack server delete $newserver
