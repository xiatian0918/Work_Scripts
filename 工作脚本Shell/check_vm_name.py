#!/usr/bin/env python
import sys

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


def sel(input_ip):
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
        if key == None:
            break
        ip = long2ip(int(value))
        final[key] = ip
    for key, value in final.items():
        if value == input_ip:
            return key


if __name__ == '__main__':
    name = sys.argv[1]
    print(sel(name))
