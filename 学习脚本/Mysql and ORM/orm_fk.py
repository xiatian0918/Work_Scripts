#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy import func
from sqlalchemy import DATE

engine = create_engine("mysql+pymysql://root:xiatian123456@192.168.56.11/oldboydb",
                       encoding='utf-8',echo=True)   # echo=true 就是打印所有的信息

Base = declarative_base()  # 生成orm基类

class Student(Base):
    __tablename__ = "student"
    id = Column(Integer,primary_key=True)
    name = Column(String(32),nullable=False)
    register_date = Column(DATE,nullable=False)

    def __repr__(self):
        return "<%s name:%s>" %(self.id,self.name)

class StudyRecord(Base)
    __tablename__ = "study_record"
    id = Column(Integer,primary_key=True)
    day = Column(Integer)



