#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import paramiko,time
parament = input("请输入所有计算节点统一执行的命令: ")

shell = "ansible tgc-node -m win_shell -a %s" %(parament)
def sshclient_execmd(hostname, port, username, password, execmd):
    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")
    print(stdout.read().decode())
    s.close()

def main():
    hostname = '192.168.0.52'
    port = 22
    username = 'root'
    password = 'Toprs!@#123'
    execmd = shell
    sshclient_execmd(hostname, port, username, password, execmd)


if __name__ == "__main__":
    main()
