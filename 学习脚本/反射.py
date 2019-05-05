#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


def bulk(self):
    print("%s is yelling...." %self.name)


class Dog(object):

    def __init__(self,name):
        self.name = name

    def eat(self,food):
        print("%s is eating..." %self.name,food)

d = Dog("NiuHanYang")
choice = input(">>:").strip()

if hasattr(d,choice):
    func = getattr(d,choice)
    func("ChenRonghua")
else:
    # setattr(d,choice,bulk)
    # d.talk(d)
    setattr(d,choice,33)
    print( getattr(d,choice))
