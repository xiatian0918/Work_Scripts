#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# 创建只包含一个元素的tuple
a_tuple = (2,)
b_tuple = [2,]
c_tuple = (2)
print(type(a_tuple))
print(type(b_tuple))
print(type(c_tuple))

# 列表与元素混合
mixed_tuple = (1,2,['a','b'])
print("mixed_tuple: ",mixed_tuple)

mixed_tuple[2][0] = 'c'
mixed_tuple[2][1] = 'd'
print("mixed_tuple after: ",mixed_tuple)

