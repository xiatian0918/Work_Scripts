#!/usr/bin/env python
# -*- coding:utf-8 -*-

'''
这个脚本获取windows系统下所有的word和excel文件
'''

import os 
disk_name = input("请输入获取的盘符名称:")

file_type = ['doc','docx','xls','xlsx']
for i in file_type:
#    comand = "dir %s:\\*.%s /s >>%s:\\file.txt" %(disk_name,i,disk_name)
    comand = "dir %s:\\*.%s /s >>D:\\file.txt" %(disk_name,i)
    a = os.popen(comand)
    print(a.read())

