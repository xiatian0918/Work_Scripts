#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from sqlalchemy import Table, Column, Enum,Integer,String,DATE, ForeignKey,engine
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine,UniqueConstraint
from sqlalchemy.orm import sessionmaker
from sqlalchemy_utils import ChoiceType,PasswordType

Base = declarative_base()

class Host(Base):
    __tablename__ = 'host'
    id = Column(Integer,primary_key=True)
    hostname = Column(String(64),unique=True)
    ip = Column(String(64),unique=True)
    port = Column(Integer,default=22)

    def __repr__(self):
        return self.hostname

class HostGroup(Base):
    __tablename__ = 'host_group'
    id = Column(Integer, primary_key=True)
    name = Column(String(64), unique=True)

    def __repr__(self):
        return self.name

class RemoteUser(Base):
    __tablename__ = 'remote_user'
    id = Column(Integer, primary_key=True)
    AuthTypes = [
        ('ssh-passwd','SSH/Password'),
        ('ssh-key','SSH/KEY'),
    ]
    auth_type = Column(ChoiceType(AuthTypes))
    username = Column(String(32))
    password = Column(String(128))
    __table_args__ = (UniqueConstraint('auth_type', 'username', 'password', name='_user_passwd_uc'),)

    def __repr__(self):
        return self.username

class UserProfile(Base):
    __tablename__ = 'user_profile'
    id = Column(Integer, primary_key=True)
    username = Column(String(32),unique=True)
    password = Column(String(128))

    def __repr__(self):
        return self.username

class Auditlog(Base):
    pass
