#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy import func

engine = create_engine("mysql+pymysql://root:xiatian123456@192.168.56.11/oldboy",
                       encoding='utf-8')   # echo=true 就是打印所有的信息

Base = declarative_base()  # 生成orm基类

class User(Base):
    __tablename__ = 'user'  # 表名
    id = Column(Integer, primary_key=True)
    name = Column(String(32))
    password = Column(String(64))

    def __repr__(self):
        return "<%s  name:%s>" %(self.id,self.name)

Base.metadata.create_all(engine)  # 创建表结构

Session_class = sessionmaker(bind=engine)  # 创建与数据库的会话session class ,注意,这里返回给session的是个class,不是实例
Session = Session_class()  # 生成session实例

# data= Session.query(User).filter(User.id>1).filter(User.id <3).first()
# # print(data)
#
# data.name = "lala"
# data.password = "Shut Happens"

# 回滚
# fake_user = User(name='Rain', password='12345')
# Session.add(fake_user)
# print(Session.query(User).filter(User.name.in_(['Jack','rain'])).all() )
# Session.rollback()
#Session.commit()

# 统计
# fake_uery(Ususer = User(name='Rain', password='12345')
# # Session.add(fake_user)
# Session.query(User).filter(User.name.in_(['Jack','rain'])).count()

# 分组
#print(Session.query(func.count(User.name),User.name).group_by(User.name).all() )
# print(Session.query(func.count(User.name),User.name).group_by(User.name).all() )

# 删除
# data= Session.query(Users).filter(Users.id > 2).delete()
# Session.commit()

