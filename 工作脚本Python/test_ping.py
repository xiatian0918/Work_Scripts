#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os
ip_list = ["192.168.0.52","192.168.0.53","192.168.0.54","192.168.0.55","192.168.0.56"]

for i in ip_list:
    a = os.popen('ping %s' %(i) )
    print (str(a.read()))
