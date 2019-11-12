#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


import requests, sys
dir_name = sys.argv[1]
url = 'http://192.168.0.59/upload'
files = {'file': open('%s' %dir_name, 'rb')}

response = requests.post(url, files=files)

#name = dir_name.split('data1\\\\', 1)

print(response)
#print(name[1])
