#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian
# 获取端口进程脚本

import os

win_port = input("请输入您想要查看被占用的端口号: ")
info_port = os.popen("netstat -ano|findstr %s" %win_port).read()
# print(info_port)
pid_port = info_port.split('\n')
# print(pid_port)
name_pid = pid_port[0].split(' ')[-1]

serv_pid = os.popen("tasklist|findstr %s" %name_pid).read()
print(serv_pid)

# try:
#     import hotxia
# except Exception as e:
#     pass
