#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os
ip_list = ["*******.52","*******.53","*******.54","*******.55","*******.56"]

for i in ip_list:
    a = os.popen('ping %s' %(i) )
    print (str(a.read()))
