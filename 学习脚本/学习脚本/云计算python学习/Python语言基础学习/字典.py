#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# 创建一个字典
phone_book = {'Tom':123,
              'Jerry':456,
              'Kim':789}

mixed_dict = {'Tom':'boy',
              11:23.5}

# 访问字典中的一个key的值
print("Tom has phone number: ",phone_book['Tom'])

# 修改字典中的值
phone_book['Tom'] = 999
print("Tom has phone number after: ",phone_book['Tom'])

# 添加新的key value
phone_book['Heath'] = 888
print("The add book is: ",phone_book)

# 删除字典中的一个元素
del phone_book['Tom']
print("The del book is: ",phone_book)

# 清空字典中的所有内容，变成空字典
phone_book.clear()
print("The book after clear is: ",phone_book)

# 删掉整个字典
del phone_book
# print("The book after del is: ",phone_book)

# 不允许同一个key出现两次
rep_test = {'Name':'aa',
            'age':5,
            'Name':'bb'}
print("rep_test: ",rep_test)

# key是不可变的,元组是可以写进字典的
# list_dic = {['Name']:'John',
#             'Age':13}

list_dic = {('Name'):'John',
            'Age':13}