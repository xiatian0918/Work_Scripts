#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import sqlalchemy

from sqlalchemy import create_engine,Column, Integer, String, func, DATE,ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


engine = create_engine("mysql+pymysql://root:xiatian123456@192.168.56.11/oldboydb",
                       encoding='utf-8')   # echo=true 就是打印所有的信息

Base = declarative_base()  # 生成orm基类

class Student(Base):
    __tablename__ = "student"
    id = Column(Integer,primary_key=True)
    name = Column(String(32),nullable=False)
    register_date = Column(DATE,nullable=False)

    def __repr__(self):
        return "<%s name:%s>" %(self.id,self.name)

class StudyRecord(Base):
    __tablename__ = "study_record"
    id = Column(Integer,primary_key=True)
    day = Column(Integer,nullable=False)
    status = Column(String(32),nullable=False)
    stu_id = Column(Integer,ForeignKey("student.id"))

    def __repr__(self):
        return "<%s  name:%s>" % (self.id, self.day)

Base.metadata.create_all(engine)  # 创建表结构

Session_class = sessionmaker(bind=engine)  # 创建与数据库的会话session class ,注意,这里返回给session的是个class,不是实例
session = Session_class()  # 生成session实例

# s1 = Student(name="Alex",register_date="2014-05-21")
# s2 = Student(name="Jack",register_date="2014-04-21")
# s3 = Student(name="Rain",register_date="2014-03-21")
# s4 = Student(name="Eric",register_date="2014-02-21")
#
# study_obj1 = StudyRecord(day=1,status="YES",stu_id=1)
# study_obj2 = StudyRecord(day=2,status="NO",stu_id=1)
# study_obj3 = StudyRecord(day=3,status="YES",stu_id=1)
# study_obj4 = StudyRecord(day=1,status="YES",stu_id=2)
#
# session.add_all([s1,s2,s3,s4,study_obj1,study_obj2,study_obj3,study_obj4])

stu_obj = session.query(Student).filter(Student.name=="alex").first()
print(stu_obj.my_classes)
session.commit()









