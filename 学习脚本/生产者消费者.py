#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import threading,time,queue
q = queue.Queue()
def Producer(name):
    for i in range(10):
        q.put("骨头%s" %i)

def Consumer(name):
    while q.qsize()>0:
        print("[%s] 取到[%s] 并且吃了它..." %(name,q.get()))


p = threading.Thread(target=Producer,args=("Alex",))
c = threading.Thread(target=Consumer,args=("hahha",))