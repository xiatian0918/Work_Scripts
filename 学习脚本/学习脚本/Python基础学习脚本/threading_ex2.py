#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import threading
import time

class MyThread(threading.Thread):
    def __init__(self,n):
        super(MyThread,self).__init__()
        self.n = n

    def run(self):
        print("runnit task",self.n)

