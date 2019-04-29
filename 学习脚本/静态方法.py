#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

class Dog(object):

    def __init__(self,name):
        self.name = name

    @staticmethod  #实际上跟类没什么关系了
    def eat(self,food):
        print("%s is eating %s" %(self.name,food))

d = Dog("ChenRongHua")
d.eat()