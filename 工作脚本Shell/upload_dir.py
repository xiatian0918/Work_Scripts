#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


import requests, sys
from os import listdir
from os.path import isfile, join

onlyfiles = [ f for f in listdir('E:\\data1\\') \
              if isfile(join('E:\\data1\\',f)) ]

for dir_name in onlyfiles:
    base_name = "E:\\data1\\%s" %dir_name
    url = 'http://192.168.0.59/upload'
    files = {'file': open('%s' %base_name, 'rb')}
    response = requests.post(url, files=files)
    print("上传到共享存储中的图片为：%s" %dir_name,"" ,"上传状态为：%s" %response)
