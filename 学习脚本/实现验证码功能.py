#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import random

''' 数字验证码
checkcode=''
for i in range(4):
    current=random.randint(0,9)
    checkcode+=str(current)
print(checkcode)               #数字验证码 '''

# checkcode=''                   # 包含字母验证码
# for i in range(5):
#     current=random.randrange(0,5)
#     if current == i:
#         tmp=chr(random.randint(65,90))
#     else:
#         tmp=random.randint(0,9)
#     checkcode+=str(tmp)
# print(checkcode)
#

import sys,os
a = sys.argv[1: ]
#print(a)
for i in a:
    print(i)
    b = os.popen("nslookup %s\n" %i ).read()
    print(b)
