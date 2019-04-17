from psutil import net_if_addrs
import socket
import uuid

hostname = socket.gethostname()
ip = socket.gethostbyname(hostname)

for k, v in net_if_addrs().items():
   if k =="本地连接 2":
        for item in v[0:1]:
            address = item[1]
            if '-' in address and len(address)==17:
               #print(address)

                print("*****************信息获取如下所示：**********************")

                print("主机名：",hostname)
                print("IP：",ip)
                print("MAC：",address)
