#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# import queue
#
# #q = queue.LifoQueue()
#
# q = queue.PriorityQueue()
# q.put((-1,"xiatian"))
# q.put((3,"hanyang"))
# q.put((10,"alex"))
# q.put((6,"wangseng"))
#
# print(q.get())
# print(q.get())
# print(q.get())
# print(q.get())
# # q.put(1)
# # q.put(2)
# # q.put("dasd")
# #
# # print(q.get())
# # print(q.get())
# # print(q.get())


import sys

long = sys.argv[1]
print(type(long))

def long2ip(long):
    """将10进制转回ip"""
    floor_list = []
    yushu = long
    for i in reversed(range(4)):  # 3,2,1,0
        res = divmod(yushu, 256 ** i)
        floor_list.append(str(res[0]))
        yushu = res[1]
    return '.'.join(floor_list)

print(int(long2ip(long)))