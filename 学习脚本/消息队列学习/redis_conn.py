#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import redis,time

# r = redis.Redis(host='192.168.56.11', port=6380)
#
# r.set('foo', 'Bar')
# print (r.get('foo'))


pool = redis.ConnectionPool(host='192.168.56.11', port=6380,db=5)

r = redis.Redis(connection_pool=pool)

# pipe = r.pipeline(transaction=False)
pipe = r.pipeline(transaction=True)

r.brpoplpush('names','name2',timeout=30)
r.set('name7','wupeiqi')
# r.set('name', 'alex')
# #time.sleep(20)
# r.set('role', 'sb')
#
pipe.execute()