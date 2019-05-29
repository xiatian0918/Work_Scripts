#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import socket
import uuid

# 获取主机名
hostname = socket.gethostname()
#获取IP
ip = socket.gethostbyname(hostname)

# 获取Mac地址
from psutil import net_if_addrs
list1=[]
for k, v in net_if_addrs().items():
    for item in v:
        address = item[1]
        if  '-' in address and len(address)==17:
            list1.append(address)

print("IP：",ip)
print("Mac地址：",list1[0])

