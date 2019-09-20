#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# 创建函数
def say_hi():
    print("hi!")

say_hi()

# 创建有参数的函数
def prt_sum_two(a,b):
    c = a + b
    print(c)

prt_sum_two(3,6)

# 传入字符串到函数
def hello_some(str):
    print("hello %s !" %str)

hello_some("China")

# 有返回值的函数
def repeat_str(str,times):
    repeat_strs = str * times
    return repeat_strs

repeated_string = repeat_str("Happy Birthday!\t",4)
print(repeated_string)

# 全局变量与局部变量
x = 60
def foo(x):
    print("x is: ",x)
    x = 3
    print("change local x ",x)

foo(x)
print("x is still",x)

# 默认参数
def repeat_str(str,times = 1):
    repeat_strs = str * times
    return repeat_strs

repeated_string = repeat_str("Happy Birthday!")
print(repeated_string)

# repeated_string_2 = repeat_str("Happy Birthday!\t",4)
# print(repeated_string_2)

# 关键字参数
def func(a,b=4,c=8):
    print("a is",a," b is",b," c is",c)

func(13,17)
func(125,c=24)
func(5,76,34)

# 变量参数
def prn_paras(fpara, *nums, **words):
    print("fpara: ",fpara)
    print("nums: ",nums)
    print("words: ",words)

prn_paras("hello",1,3,5,7, word = "python", another_word = "java")





