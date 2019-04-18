#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import paramiko

hostip = input("请输入要删除的虚拟机名称:")
shell = "/bin/sh /home/xiatian/vmware_api/自动化删除虚拟机.sh %s" %(hostip)

def sshclient_execmd(hostname, port, username, password, execmd):
    #paramiko.util.log_to_file("paramiko.log")

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
