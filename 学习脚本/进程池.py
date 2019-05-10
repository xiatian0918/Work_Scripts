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
    print('---->exec done:', arg)

if __name__ == '__main__':
    freeze_support()
    pool = Pool(5)

    for i in range(10):
        pool.apply(func=Foo,args=(i,))

    print('end')
    pool.close()
    #pool.join()