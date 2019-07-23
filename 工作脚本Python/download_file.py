#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

'''
这是一个下载共享目录到本地磁盘的脚本
'''

import paramiko

name = input("请输入你要复制到共享存储中的绝对路径：")

shell = "/bin/sh /data/scripts/upload_file.sh %s" %name

def sshclient_execmd(hostname, port, username, password, execmd):
    paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    print(stdout.read())

    s.close()


def main():
    hostname = '192.168.0.62'
    port = 22
    username = 'root'
    password = 'Toprs!@#123'
    execmd = shell


    sshclient_execmd(hostname, port, username, password, execmd)



if __name__ == "__main__":
    main()
