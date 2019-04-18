#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import paramiko

#hostname = ['192.168.0.21','192.168.0.22','192.168.0.23']
def shell_chmod():
    shell = "esxcli network  vswitch standard list"
    return shell

def sshclient_execmd(hostname, port, username, password, execmd):
    #paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    result=stdout.read().decode()

    s.close()
    return result


def main1(hostname):
    hostname =hostname
    port = 22
    username = 'root'
    password = 'Toprs!@#123'
    shell=shell_chmod()
    execmd = shell


    result=sshclient_execmd(hostname, port, username, password, execmd)
    with open('./vss.txt','a+') as f:
        f.write('\n'+hostname+'\n'+'-----------------------------'+'\n')
        f.write(result)
def main():
    for i in  ['192.168.0.21','192.168.0.22','192.168.0.23']:
        main1(i)



if __name__ == "__main__":
    main()