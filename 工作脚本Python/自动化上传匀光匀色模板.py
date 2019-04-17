#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import paramiko


shell = "/bin/sh /data/scripts/自动化上传匀光匀色模板.sh"

def sshclient_execmd(hostname, port, username, password, execmd):
    #paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    print(stdout.read().decode().strip())

    s.close()


def main():
    hostname = '*******.62'
    port = 22
    username = 'root'
    password = '*******!@#123'
    execmd = shell


    sshclient_execmd(hostname, port, username, password, execmd)


if __name__ == "__main__":
    main()