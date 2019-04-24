#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

class Dog:
    def __init__(self,name):
        self.name = name

    def bulk(self):
        print("%s: wang wang wang" %(self.name))

d1 = Dog("陈世美")
d2 = Dog("陈三炮")
d3 = Dog("陈老炮")

d1.bulk()
d2.bulk()
d3.bulk()