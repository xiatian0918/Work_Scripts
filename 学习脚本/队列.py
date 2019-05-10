#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import queue

q = queue.LifoQueue()

q.put(1)
q.put(2)
q.put(3)

q.get()
