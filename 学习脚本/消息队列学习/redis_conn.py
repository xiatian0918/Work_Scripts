#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import redis


r = redis.Redis(host='192.168.56.11', port=6380)

r.set('foo', 'Bar')
print (r.get('foo'))