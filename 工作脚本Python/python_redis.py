#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import redis

pool = redis.ConnectionPool(host='192.168.0.63', port=6379)

r = redis.Redis(connection_pool=pool)
r.set( 'foo', 'xia' )
print (r.get('foo'))