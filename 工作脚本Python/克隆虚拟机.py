#!/usr/bin/env/python

import paramiko


vc_temp = input("请输入要克隆的虚拟机模板：")
vc_name_after = input("请输入克隆后的虚拟机名称为：")


shell = "/bin/sh /data/scripts/auto_clone_vm.sh  %s %s" \
       %(vc_temp,vc_name_after)


def sshclient_execmd(hostname, port, username, password, execmd):
    #paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    print(stdout.read())

    s.close()


def main():
    hostname = '192.168.0.64'
    port = 22
    username = 'root'
    password = 'Toprs!@#123'
    execmd = shell


    sshclient_execmd(hostname, port, username, password, execmd)



if __name__ == "__main__":
    main()

