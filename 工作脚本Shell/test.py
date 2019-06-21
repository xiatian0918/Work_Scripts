#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import winrm
import paramiko
shell = "/bin/sh /data/scripts/get_dhcp.sh"
wintest = winrm.Session('http://192.168.0.85:5985/wsman',auth=('administrator','Toprs!@#123'))
result = wintest.run_cmd("netsh dhcp server 192.168.0.85 scope 192.168.0.0 show clients")

f = open("/tmp/out.txt", "w")
print(result.std_out.decode().strip())
f.close()

def sshclient_execmd(hostname, port, username, password, execmd):
    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")

    for i in range(1,9):
        print(stdout.readline().strip())
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
