#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import queue

#q = queue.LifoQueue()

q = queue.PriorityQueue()
q.put((-1,"xiatian"))
q.put((3,"hanyang"))
q.put((10,"alex"))
q.put((6,"wangseng"))

print(q.get())
print(q.get())
print(q.get())
print(q.get())
# q.put(1)
# q.put(2)
# q.put("dasd")
#
# print(q.get())
# print(q.get())
# print(q.get())