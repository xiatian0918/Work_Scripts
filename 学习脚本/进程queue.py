#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


from multiprocessing import Queue,Process

import queue,threading

# def f(q):
#     q.put([42, None, 'hello'])

def f(qq):
    qq.put([42, None, 'hello'])

if __name__ == '__main__':
    q = Queue()
    p = Process(target=f, args=(q,))
   # p = threading.Thread(target=f, )
    p.start()
    print(q.get())  #print "[42, None, 'hello']"
    p.join()