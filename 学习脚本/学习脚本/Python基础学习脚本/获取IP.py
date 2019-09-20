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
def get_mac_address():
    print(uuid.getnode())
    mac=uuid.UUID(int = uuid.getnode()).hex[-12:]
    print(mac)
    return ":".join([mac[e:e+2] for e in range(0,11,2)])

# ipList = socket.gethostbyname_ex(hostname)
# print(ipList)
#print("主机名：",hostname)
print("IP：",ip)
# print("Mac地址：",get_mac_address())
from psutil import net_if_addrs
list1=[]
for k, v in net_if_addrs().items():
    for item in v:
        address = item[1]
        if  '-' in address and len(address)==17:
            list1.append(address)
# print(list1)
print("Mac地址：",list1[0])

