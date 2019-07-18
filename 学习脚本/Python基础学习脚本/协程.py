#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import time
from greenlet import greenlet

# def func1():
#     print("in func 1")
#     time.sleep(5)
#     print("home exec done")
#
# def func2():
#     print("in func 2")
#     time.sleep(5)
#
# def func3():
#     print("in func 3")
#
# if __name__ == '__main__':
#     func1()
#     func2()
#     func3()

def test1():
    print(12)
    gr2.switch()
    print(34)
    gr2.switch()

def test2():
    print(56)
    gr1.switch()
    print(78)

gr1 = greenlet(test1)
gr2 = greenlet(test2)
gr1.switch()
