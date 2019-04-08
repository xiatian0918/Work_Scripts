

#!/usr/bin/env python
# author: xiatian

import sys
import os
import socket
ip = socket.gethostbyname(socket.getfqdn(socket.gethostname()))

print(ip)
'''
folder = os.path.exists(r"E:\\xiatian_test")
if not folder:
    os.makedirs(r"E:\\xiatian_test")

f = open("E:\\xiatian_test\\域名.txt",'w',encoding="utf-8")
f.write("web.toprs.cloud.com\ndown.toprs.cloud.com\napi.toprs.cloud.com\n\
monitor.toprs.cloud.com\ngit.toprs.cloud.com\nredmine.toprs.cloud.com")
f.close()
c = open("E:\\xiatian_test\\域名.txt","r")

for i in c:
    b = os.popen("nslookup %s\n" %i ).read()
    doc = open("E:\\xiatian_test\\%s_测试结果.txt" %ip ,'a')
    print(b, file=doc)

doc.close()
c.close()
os.remove("E:\\xiatian_test\\域名.txt")'''