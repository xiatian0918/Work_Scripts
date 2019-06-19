#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian13132dsfsdfdfsfdsesfsdfsdfdsf
#这个脚本可以过滤出保密检查工具中扫描出来的文档，包含合同与投标字样的涉密文件

import paramiko
your_name=input("请输入你的名字：")

shell = "/bin/sh /data/scripts/modify_secret.sh %s " %your_name

def sshclient_execmd(hostname, port, username, password, execmd):

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    print(stdout.read().decode())

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