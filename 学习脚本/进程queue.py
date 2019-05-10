#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from multiprocessing import Queue,Process

import queue,threading

# def f(q):
#     q.put([42, None, 'hello'])

def f():
    q.put([42, None, 'hello'])

if __name__ == '__main__':
    q = queue.Queue()
    p = Process(target=f, )
#    p = threading.Thread(target=f, )
    p.start()
    print(q.get())
    p.join()