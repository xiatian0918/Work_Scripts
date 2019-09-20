#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# 面向对象
class Student:
    def __init__(self,name,grade):
        self.name = name
        self.grade = grade

    def introduce(self):
        print("hi! I'm %s" %self.name)
        print("my grade is: %s" %self.grade)

    def improve(self,amount):
        self.grade = self.grade + amount

jim = Student("jim",86)
jim.introduce()

jim.improve(10)
jim.introduce()

# 装饰器
def add_candles(cake_func):
    def insert_candles():
        return cake_func() + " and candles "
    return insert_candles()

@add_candles
def make_cake():
    return "cake"

# gift_func = add_candles(make_cake)

print(make_cake)
# print(gift_func)