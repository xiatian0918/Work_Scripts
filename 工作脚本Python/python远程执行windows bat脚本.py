#!/usr/bin/env python
# author: xiatian

import wmi,json
import time

logfile = 'logs_192.168.0.81.txt'

#远程执行bat文件
def call_remote_bat():
     try:
        #用wmi连接到远程服务器
        conn = wmi.WMI(computer='192.168.0.81', user='administrator', password='Toprs!@#123')
        filename=r"C:\test.bat"   #此文件在远程服务器上
        cmd_callbat=r"cmd /c call %s"%filename
        a=conn.Win32_Process.Create(CommandLine=cmd_callbat)  #执行bat文件
        print(a)
#        print ("执行成功!")
        return True
     except Exception as e:
        log = open(logfile, 'a')
        log.write(('192.168.0.81, call bat Failed!\r\n'))
        log.close()
        return False
     return False
call_remote_bat()
# if __name__=='__main__':
#     call_remote_bat(computer="192.168.0.85" , user="administrator", password="Toprs!@#123")