#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import threading

def run(name):
    print("%s run thread...." %name)

t_res = []
for i in range(5):
    t = threading.Thread(target=run,args=('xiatian',))
    t.start()
    t_res.append(t)

for r in t_res:
    r.join()