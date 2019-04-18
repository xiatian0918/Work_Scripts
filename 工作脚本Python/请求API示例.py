#!/usr/bin/env python
#coding:utf-8
import requests,json
url="http://api.toprs.cloud.com/user/login/"
headers={'Content-Type':'application/json;charset=UTF-8'}
request_param={
    "username":"测试001",
    "password":"123456"
}
response=requests.post(url,data=json.dumps(request_param), headers=headers)
a = response.text
print(a[0:9])