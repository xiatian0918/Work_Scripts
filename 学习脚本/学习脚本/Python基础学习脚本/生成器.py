#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# import time
# def consumer(name):
#     print("%s 准备开始吃包子啦！" %(name))
#     while True:
#         baozi = yield
#
#         print("包子%s来了，被%s吃了！" %(baozi,name))
#
# c = consumer("HotXia")
# c.__next__()
# c.__next__()

#!/usr/bin/env python

import pymysql


def long2ip(long):
    """将10进制转回ip"""
    floor_list = []
    yushu = long
    for i in reversed(range(4)):  # 3,2,1,0
        res = divmod(yushu, 256 ** i)
        floor_list.append(str(res[0]))
        yushu = res[1]
    return '.'.join(floor_list)


def sel():
    connection = pymysql.connect(
        host='192.168.0.53',
        port=3306,
        user='root',
        password='123456789',
        db='toprs'
    )
    cur = connection.cursor()
    cur.execute("select vm_name,vm_ip from tb_vm")

    result = dict(cur.fetchall())
    final = {}
    for key, value in result.items():
        ip = long2ip(int(value))
        final[key] = ip
    print(final)


if __name__ == '__main__':
    sel()
