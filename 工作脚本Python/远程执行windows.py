#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import winrm
#a = ['*******.91','*******.92','*******.97']
a = "*******.91"
#for i in a:
wintest = winrm.Session('http://%s:5985/wsman' %(a),auth=('*******istrator','*******!@#123'))
result = wintest.run_cmd("dir")
b = result.status_code
print(b)
    # if b == 0:
    #     print("虚拟机:%s,可以正常运行使用" %(i))
    # else:
    #     exit(4)

