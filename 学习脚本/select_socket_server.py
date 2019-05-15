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

server.accept()