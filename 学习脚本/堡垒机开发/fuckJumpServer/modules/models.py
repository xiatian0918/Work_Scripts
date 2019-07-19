#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from sqlalchemy import Table, Column, Integer,String,DATE, ForeignKey,engine
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
# from sqlalchemy import create_engine
# from sqlalchemy.orm import sessionmaker

Base = declarative_base()
class