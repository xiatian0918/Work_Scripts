#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian
'''如何检查mongo主从关系端口脚本'''

import paramiko
shell = "/bin/sh /data/scripts/check_mongo_rep.sh"
def sshclient_execmd(hostname, port, username, password, execmd):
    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")
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
