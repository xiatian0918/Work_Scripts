#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from multiprocessing import Process,Pool,freeze_support
import os
import time

def Foo(i):
    time.sleep(2)
    print("in process",os.getpid())
    return i+100

def  Bar(arg):
    print('---->exec done:', arg,os.getpid())

if __name__ == '__main__':
    freeze_support()
#    pool = Pool(5)
    pool = Pool(processes=3)   #允许进程池同时放入5个进程
    print("主进程",os.getpid())

    for i in range(10):
 #       pool.apply(func=Foo,args=(i,))     #串行
 #       pool.apply_async(func=Foo, args=(i,))
        pool.apply_async(func=Foo, args=(i,), callback=Bar)
    print('end')
    pool.close()
    pool.join()