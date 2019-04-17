#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import getpass

_username = 'xiatian'
_password = 'abc123'
username = input("username:")
#password = getpass.getpass("password:")
password = input("password:")
if _username == username and _password == password:
    print("Welcome user %s login..." %(username))
else:
    print("Invalid username or password!")
