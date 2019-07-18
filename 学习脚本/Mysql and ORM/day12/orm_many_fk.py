#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from sqlalchemy import Integer, ForeignKey, String, Column
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()

class Customer(Base):
    __tablename__ = 'customer'
    id = Column(Integer, primary_key=True)
    name = Column(String(64))

    billing_address_id = Column(Integer, ForeignKey("address.id"))
    shipping_address_id = Column(Integer, ForeignKey("address.id"))

    billing_address = relationship("Address",foreign_keys=[billing_address_id])
    shipping_address = relationship("Address",foreign_keys=[shipping_address_id])

class Address(Base):
    __tablename__ = 'address'
    id = Column(Integer, primary_key=True)
    street = Column(String(64),nullable=False)
    city = Column(String(64),nullable=False)
    state = Column(String(64),nullable=False)

    def __repr__(self):
        return self.street
engine = create_engine("mysql+pymysql://root:xiatian123456@192.168.56.11/oldboydb",
                       encoding='utf-8')

Base.metadata.create_all(engine)