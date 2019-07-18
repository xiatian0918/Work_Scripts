#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from day12 import orm_m2m
from sqlalchemy.orm import sessionmaker
from sqlalchemy import engine

Session_class = sessionmaker(bind=orm_m2m.engine)
session = Session_class()

# b1 = orm_m2m.Book(name="learn python with Alex",pub_date="2014-05-02")
# b2 = orm_m2m.Book(name="learn Zhangbility with Alex",pub_date="2015-05-02")
# b3 = orm_m2m.Book(name="learn hook up girls with Alex",pub_date="2016-05-02")
#
# a1 = orm_m2m.Author(name="Alex")
# a2 = orm_m2m.Author(name="Jack")
# a3 = orm_m2m.Author(name="Rain")
#
# b1.authors = [a1,a3]
# b3.authors = [a1,a2,a3]
#
# session.add_all([b1,b2,b3,a1,a2,a3])

author_obj = session.query(orm_m2m.Author).filter(orm_m2m.Author.name=="alex").first()
print(author_obj.books[1].pub_date)
book_obj = session.query(orm_m2m.Book).filter(orm_m2m.Book.id==2).first()
print(book_obj.authors)

session.commit()
