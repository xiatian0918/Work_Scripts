#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian
#__author__ = xiatian
from smb.SMBConnection import SMBConnection
def get_script_file():
    conn = SMBConnection('admin', 'password', 'HotXia-PC', '\\192.168.0.29\Toprs-rd3-60T')
    print(conn.connect('192.168.0.29', 20))
    conn.listPath('\\192.168.0.29\\Toprs-rd3-60T')
    # sharelist = conn.listShares()#列出共享目录
    # for i in sharelist:
    #     print (i)