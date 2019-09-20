#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import select,socket,sys,queue

server = socket.socket()
server.bind(('localhost',9000))
server.listen(1000)

server.setblocking(False) #不阻塞

inputs = [server,]
outputs = []

readable , writeable, exceptional = select.select(inputs, outputs, inputs)
print(readable,writeable,exceptional)
for i in readable:
    if r is server: #代表来了一个新链接
        conn,addr = server.accept()
        print("来了个新链接",addr)
        inputs.append(conn)
    else:
        data = conn.recv(1024)
        print("收到数据",data)
