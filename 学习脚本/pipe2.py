#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from multiprocessing import Process, Pipe
import os
# def f(conn):
#     conn.send([42, None, 'hello from child1'])
#     conn.send([42, None, 'hello from child2'])
#     print("from parent:", conn.recv())
#     conn.close()
#
#
# if __name__ == '__main__':
#     parent_conn, child_conn = Pipe()

