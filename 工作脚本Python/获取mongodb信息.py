#!/usr/bin/env python
#-*- coding: UTF-8 -*-
#导入模块

from pymongo import MongoClient
#建立Mongodb数据库连接
client=MongoClient('192.168.0.59',27019)
#test为数据库
db=client.toprs
#test为集合，相当于表名
collection=db.haha
#插入集合数据
#collection.insert({'name':'xiatian','age':'27'})
#print collection.find_one()
#打印集合中所有数据
for item in collection.find():
    print (item)