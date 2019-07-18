#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian
#
# for letter in ('Python','shell'):  # 第一个实例
#     print('当前字母 :', letter)
#
# fruits = ['banana', 'apple', 'mango']
# for fruit in fruits:  # 第二个实例
#     print('当前水果 :', fruit)
#
# print("Good bye!")

# print("nihao")

import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker

engine = create_engine("mysql+pymysql://root:xiatian123456@192.168.56.11/oldboy",
                       encoding='utf-8')   # echo=true 就是打印所有的信息

Base = declarative_base()

class User(Base):
    __tablename__ = 'user'  # 表名
    id = Column(Integer, primary_key=True)
    name = Column(String(32))
    password = Column(String(64))

Base.metadata.create_all(engine)

user_obj1 = User(name="alex", password="alex123456")  # 生成你要创建的数据对象
user_obj2 = User(name="jack", password="jack123456")
user_obj3 = User(name="tom", password="tom123456")
user_obj4 = User(name="jason", password="jason123456")


    print("user_obj%s" %i)