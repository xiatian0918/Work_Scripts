#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os,threading,multiprocessing
from multiprocessing import Process

def info(title):
    print(title)
    print('module name:', __name__)
    print('parent process:', os.getppid())
    print('process id:', os.getppid())
    print("\n\n")


def f(name):
    info('\033[31:1mcalled from child process function f\033[0m')
    print('hello',name)

if __name__ == '__main__':
    info('\033[32:1mmain process line\033[0m')
    p = Process(target=f,args=('bob',))
    p.start