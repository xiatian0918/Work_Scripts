#!/usr/bin/env python
# -*- coding:utf-8 -*-


import urllib2
import json

def http_put():
    url='https://*******/rest/vcenter/vm/vm-76/hardware/cpu'
    values={
        "spec": { \
        "count": 17, \
        "hot_add_enabled": false, \
        "hot_remove_enabled": false, \
        "cores_per_socket": 1 \
        } \
    }
    jdata = json.dumps(values)   # 对数据进行JSON格式化编码
    request = urllib2.Request(url, jdata)
  #  request.add_header('Content-Type', 'application/json')
#	request.add_header('Accept', 'application/json')
    request.add_header('vmware-api-session-id,262cd841c442b32c888205f66ee21291')
    request.get_method = lambda:'PATCH'           # 设置HTTP的访问方式
    request = urllib2.urlopen(request)
    return request.read()

resp = http_put()