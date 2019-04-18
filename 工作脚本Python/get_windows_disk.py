#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os

#for a in ('192.168.0.81','192.168.0.82','192.168.0.83','192.168.0.84'):
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
  sys_version(ipaddress="192.168.0.82", user="administrator", password="Toprs!@#123")