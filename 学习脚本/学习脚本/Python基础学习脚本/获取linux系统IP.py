#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os
# ip = os.system('ifconfig')
# print(ip)

ip_addr = os.popen("ipconfig").read()
print(ip_addr)