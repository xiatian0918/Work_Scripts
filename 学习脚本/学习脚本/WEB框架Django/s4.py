#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import hashlib,os

m = hashlib.md5()
# m.update('ffffff'.encode('utf-8'))不
m.update('fffffff')
ret = m.hexdigest()
print(ret)