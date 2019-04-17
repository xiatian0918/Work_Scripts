#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import time

'''
ti = time.strftime("%X")
print (ti)

'''

millis = int(round(time.time() * 1000))
print (millis)

millis_02 = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(millis/1000))
print(millis_02)