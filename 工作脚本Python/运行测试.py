
import socket
domain = ['web.toprs.cloud.com','api.toprs.cloud.com','down.toprs.cloud.com', \
           'monitor.toprs.cloud.com','git.toprs.cloud.com','redmine.toprs.cloud.com', \
           'log.toprs.cloud.com','network.toprs.cloud.com','mail.toprs.cloud.com']
for host in domain:
     ip = socket.gethostbyname(host)
     print("域名是: %s \n解析记录为: %s\n" %(host,ip))

# import os
# #os.system("Get-DhcpServerv4Scope | Get-DhcpServerv4Lease>c:\\b.txt")
# print(os.popen("dir").read())
