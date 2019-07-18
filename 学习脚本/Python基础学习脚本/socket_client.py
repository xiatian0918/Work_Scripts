#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import socket

client = socket.socket() #声明socket类型，同时生成socket连接对象
client.connect(('localhost',6969))

client.send("你好世界哈哈a".encode("utf-8"))
data = client.recv(1024)
print("recv:",data.decode())
client.close()