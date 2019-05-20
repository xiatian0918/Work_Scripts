#!/usr/bin/env python
# author:HotXia

import os,socket
a = os.popen('copy C:\\Windows\\System32\\drivers\\etc\\hosts /A')
print(a.read())

domain = ['192.168.0.66      web.toprs.cloud.com\n','192.168.0.66       api.toprs.cloud.com\n', \
          '192.168.0.62      down.toprs.cloud.com\n','192.168.0.64      monitor.toprs.cloud.com\n', \
          '192.168.0.55      git.toprs.cloud.com\n','192.168.0.57       redmine.toprs.cloud.com\n', \
           '192.168.0.54     log.toprs.cloud.com\n','192.168.0.65       network.toprs.cloud.com\n', \
          '192.168.0.60      mail.toprs.cloud.com\n','192.168.0.67        images.toprs.cloud.com\n']

f = open('C:\\Windows\\System32\\drivers\\etc\\hosts',"a",encoding="utf-8")
f.write('####Toprs Cloud Domain#################\n')
for i in domain:
    f.write(i)
f.close()


yuming = ['web.toprs.cloud.com','api.toprs.cloud.com','down.toprs.cloud.com', \
           'monitor.toprs.cloud.com','git.toprs.cloud.com','redmine.toprs.cloud.com', \
           'log.toprs.cloud.com','network.toprs.cloud.com','mail.toprs.cloud.com','images.toprs.cloud.com']


for host in yuming:
     ip = socket.gethostbyname(host)
     print("域名是: %s \n解析记录为: %s\n" %(host,ip))
