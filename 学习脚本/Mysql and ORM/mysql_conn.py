#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pymysql

# 创建连接
conn = pymysql.connect(host='192.168.56.11', port=3306, user='root', passwd='xiatian123456', db='oldboy')
# 创建游标
cursor = conn.cursor()

# 执行SQL，并返回收影响行数
effect_row = cursor.execute("select * from student")
print(cursor.fetchone()) #读一行内容
# print(cursor.fetchone())
print('------------------------->')
print(cursor.fetchall())  # 读所有行