#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import paramiko

hostip = input("请输入要修改内存的虚拟机IP地址:")
state = input("请输入要修改的内存为(MB):")
shell = "/bin/sh /home/xiatian/vmware_api/vmware_host_memory.sh %s %s" %(hostip,state)

def sshclient_execmd(hostname, port, username, password, execmd):
    paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    print
    stdout.read()

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
