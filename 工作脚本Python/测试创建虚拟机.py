#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian
from datetime import datetime

import paramiko

# 克隆虚拟机后ip储存位置（运维所需）
VM_IP = '/mnt/monitor_data/vm_ip/vm_vm_ip.txt'


def shell_commond(vc_temp, vc_name_after):
    shell = "/bin/sh /data/scripts/auto_clone_vm.sh  %s %s" \
            % (vc_temp, vc_name_after)
    return shell


def sshclient_execmd(hostname, port, username, password, execmd):
    # paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    result = stdout.read().decode()
    print(result)
    # result = result[-13:]  # 获取新虚拟机IP
    # print('ip:', result)
    # s.close()
    # return result


def main(vc_temp, vc_name_after):
    hostname = '192.168.0.64'
    port = 22
    username = 'root'
    password = 'Toprs!@#123'
    execmd = shell_commond(vc_temp, vc_name_after)

    result = sshclient_execmd(hostname, port, username, password, execmd)
    return result


if __name__ == "__main__":
    t1 = datetime.now()
    main('test', 'ceshi-001')
    t2 = datetime.now()
    print(t2 - t1)

from datetime import datetime

import paramiko

# 克隆虚拟机后ip储存位置（运维所需）
VM_IP = '/mnt/monitor_data/vm_ip/vm_vm_ip.txt'


def shell_commond(vc_temp, vc_name_after):
    shell = "/bin/sh /data/scripts/auto_clone_vm.sh  %s %s" \
            % (vc_temp, vc_name_after)
    return shell


def sshclient_execmd(hostname, port, username, password, execmd):
    # paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    result = stdout.read().decode()
    print(result)
    result = result