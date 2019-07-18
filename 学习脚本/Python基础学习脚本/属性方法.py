#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# class Dog(object):
#     '''这是描述类的方法'''
#
#     def __call__(self, *args, **kwargs):
#         print("runing call")
#
# print(Dog.__doc__)
# print(Dog.__module__)
# print(Dog.__class__)
# print(Dog.__dict__)   #打印类里的所有属性，不包括示例属性
#
# d = Dog()
# d()

# class Foo(object):
#
#     def __init__(self,name):
#         self.name = name
#
#     def talk(self):
#         print("hehe")
#
# f = Foo('alex')
#
# print(type(f))
# print(type(Foo))

def func(self):
    print('hello %s' % self.name)

def __init__(self,name,age):
    self.name = name
    self.age = age

Foo = type('Foo', (object,), {'func':func,
                       '__init__':__init__})

# f = Foo('chen',34)
# f.func()
# print(type(Foo))

def f():
    a = print("hehe")
    return a

f()











