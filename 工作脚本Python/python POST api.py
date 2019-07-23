#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


import requests, sys, paramiko
from os import listdir
from os.path import isfile, join

onlyfiles = [ f for f in listdir('C:\\Users\\user\\Desktop\\api\\images\\') \
              if isfile(join('C:\\Users\\user\\Desktop\\api\\images\\',f)) ]

for dir_name in onlyfiles:
    base_name = "C:\\Users\\user\\Desktop\\api\\images\\%s" %dir_name
    url = 'http://192.168.0.59/upload'
    files = {'file': open('%s' %base_name, 'rb')}
    response = requests.post(url, files=files)
    print("上传到共享存储中的图片为：%s" %dir_name,"" ,"上传状态为：%s" %response)



#
# shell = "/bin/sh /data/scripts/modify_share_directory.sh %s" %dir_name
# def sshclient_execmd(hostname, port, username, password, execmd):
#     s = paramiko.SSHClient()
#     s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#     s.connect(hostname=hostname, port=port, username=username, password=password)
#     stdin, stdout, stderr = s.exec_command(execmd)
#     stdin.write("Y")
#     print(stdout.read().decode())
#     s.close()
#
# def main():
#     hostname = '192.168.0.62'
#     port = 22
#     username = 'root'
#     password = 'Toprs!@#123'
#     execmd = shell
#     sshclient_execmd(hostname, port, username, password, execmd)
#
# if __name__ == "__main__":
#     main()