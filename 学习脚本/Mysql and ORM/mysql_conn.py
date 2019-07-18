#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pymysql

# 创建连接
conn = pymysql.connect(host='192.168.56.11', port=3306, user='root', passwd='xiatian123456', db='oldboy')
# 创建游标
cursor = conn.cursor()

# 执行SQL，并返回收影响行数
# effect_row = cursor.execute("select * from student")
# print(cursor.fetchone()) #读一行内容
# # print(cursor.fetchone())
# print('------------------------->')
# print(cursor.fetchall())  # 读所有行


date = [
    ("N1","2015-05-22",'M',21),
    ("N2","2015-05-23",'M',22),
    ("N3","2015-05-24",'F',23),
]

cursor.executemany("insert into student (name,register_date,gender,age) values (%s,%s,%s,%s)",date)

conn.commit()  # 默认创建事务，因此要提交


