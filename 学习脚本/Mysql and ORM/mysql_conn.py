#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pymysql

# 创建连接
conn = pymysql.connect(host='192.168.56.11', port=3306, user='root', passwd='xiatian123456', db='oldboydb')
# 创建游标
cursor = conn.cursor()

# 执行SQL，并返回收影响行数
table_name = "student"
effect_row = cursor.execute("select * from %s where id>2" %table_name)
# print(cursor.fetchone()) #读一行内容
# # print(cursor.fetchone())
# print('------------------------->')
print(cursor.fetchall())  # 读所有行


# date = [
#     ("N1","2015-05-22",'M',21),
#     ("N2","2015-05-23",'M',22),
#     ("N3","2015-05-24",'F',23),
#     ("N4","2015-05-25",'F',23),
#     ("N5","2015-05-26",'F',23),
#     ("N6","2015-05-27",'F',23),
#     ("N7","2015-05-28",'F',23),
#     ("N8","2015-05-29",'F',23),
#
# ]
#
# cursor.executemany("insert into student (name,register_date,gender,age) values (%s,%s,%s,%s)",date)
#
# conn.commit()  # 默认创建事务，因此要提交


