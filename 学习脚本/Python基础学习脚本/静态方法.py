#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


class Dog(object):

    def __init__(self,name):
        self.name = name

#    @staticmethod  #实际上跟类没什么关系了
    @classmethod
    def eat(self):
        print("%s is eating %s" %(self.name,'asdasd'))

    def talk(self):
        print("%s is talking" %self.name)

d = Dog("ChenRongHua")
d.eat(d)
d.talk()