#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import socket

domain = ['web.toprs.cloud.com','api.toprs.cloud.com','down.toprs.cloud.com', \
           'monitor.toprs.cloud.com','git.toprs.cloud.com','redmine.toprs.cloud.com', \
           'log.toprs.cloud.com','network.toprs.cloud.com','mail.toprs.cloud.com','images.toprs.cloud.com']

for host in domain:
     ip = socket.gethostbyname(host)
#     print(host)
     print("域名是: %s \n解析记录为: %s\n" %(host,ip))


'''
import sys
import os
import socket
ip = socket.gethostbyname(socket.getfqdn(socket.gethostname()))


folder = os.path.exists(r"E:\\xiatian_test")
if not folder:
    os.makedirs(r"E:\\xiatian_test")

f = open("E:\\xiatian_test\\域名.txt",'w',encoding="utf-8")
f.write("web.toprs.cloud.com\ndown.toprs.cloud.com\napi.toprs.cloud.com\n\
monitor.toprs.cloud.com\ngit.toprs.cloud.com\nredmine.toprs.cloud.com\nlog.toprs.cloud.com")
f.close()
c = open("E:\\xiatian_test\\域名.txt","r")

for i in c:
    b = os.popen("nslookup %s\n" %i ).read()
    doc = open("E:\\xiatian_test\\%s_测试结果.txt" %ip ,'a')
    print(b, file=doc)

doc.close()
c.close()
os.remove("E:\\xiatian_test\\域名.txt")

f = open("E:\\xiatian_test\\%s_测试结果.txt" %ip,'r')

for i in f.readlines():
    print(i.strip())
f.close() '''

