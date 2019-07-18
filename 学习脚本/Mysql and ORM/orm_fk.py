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






