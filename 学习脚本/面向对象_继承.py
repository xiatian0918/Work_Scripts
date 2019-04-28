#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# class Role:
#     def __init__(self,name,role,weapon,life_value=100,money=15000):
#         self.name = name
#         self.role = role
#         self.weapon = weapon

class People:

    def __init__(self,name,age):
        self.name = name
        self.age = age

    def eat(self):
        print("%s is eating..." % self.name)

    def talk(self):
        print("%s is talking..." % self.name)

    def sleep(self):
        print("%s is sleeping..." % self.name)

class  Man(People):

    def xiao(self):
        print("%s is xiaoing .... 20s ...done" %self.name)

    def sleep(self):
        People.sleep(self)
        print("man is sleeping")

class Woman(People):
    def get_birth(self):
        print("%s is born a baby...." % self.name)

m1 = Man("HotXia",28)
m1.eat()
m1.xiao()
m1.sleep()

w1 = Woman("ZhangWuJi",26)
w1.get_birth()
# w1.xiao()