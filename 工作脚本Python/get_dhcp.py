#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import winrm
import paramiko
shell = "/bin/sh /data/scripts/get_dhcp.sh"
wintest = winrm.Session('http://*******.85:5985/wsman',auth=('*******istrator','*******!@#123'))
result = wintest.run_cmd("netsh dhcp server *******.85 scope *******.0 show clients")

f = open("Z:\\system\\show_dhcp\\out.txt", "w")
print(result.std_out.decode().strip(),file=f)
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
    hostname = '*******.62'
    port = 22
    username = 'root'
    password = '*******!@#123'
    execmd = shell
    sshclient_execmd(hostname, port, username, password, execmd)

if __name__ == "__main__":
    main()