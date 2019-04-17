#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os

#for a in ('*******.81','*******.82','*******.83','*******.84'):
 # for i in range(50,91):
 #     vol = chr(i) + ':'
 #     if os.path.isdir(vol):
 #         print (vol)

import wmi
def sys_version(ipaddress, user, password):
  conn = wmi.WMI(computer=ipaddress, user=user, password=password)
  for i in range(50, 91):
      vol = chr(i) + ':'
      if os.path.isdir(vol):
          print(vol)
if __name__ == '__main__':
  sys_version(ipaddress="*******.82", user="*******istrator", password="*******!@#123")