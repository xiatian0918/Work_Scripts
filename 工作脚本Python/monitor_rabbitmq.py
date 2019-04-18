#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import json
import os

zbx_srv = '192.168.0.58'
hostname = 'Rabbitmq-server'
url = 'http://192.168.0.58:15672/api/queues'

r = requests.get(url, auth=("toprs", "toprs"),  timeout=5)
parsed = json.loads(r.content)

for i in parsed:
    k = i.get('name')  #队列名
    v = i.get('messages')  #待处理队列数
    c = i.get('consumers') #消费者数
    m = i.get('memory')  ##队列消耗内存
    print(k,'     ',' ',v,'  ', c,'  ', m)
    # print("name：%s  messages：%s consumers：%s memory：%s" %(k,v,c,m))
