#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

def handle_index():
    import time
    v = str(time.time())
    f = open('View/index.html',mode='rb')
    data = f.read()
    f.close()
    data = data.replace('@UUUUU' ,'哈哈吃骨头'.encode('utf-8'))

    return [data,]
#    return [bytes('<h1>Hello, Index!</h1>', encoding='utf-8'), ]

def handle_date():
    return [bytes('<h1>Hello, Date!</h1>', encoding='utf-8'), ]
