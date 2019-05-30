#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian
# 这个脚本是把保密检查出来的文件自动保存到共享文件系统中

import shutil

import paramiko,os
your_name=input("请输入要备份的用户名字：")

shell = "/bin/sh /data/scripts/bak_file.sh %s " %your_name

def sshclient_execmd(hostname, port, username, password, execmd):

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")

    print(stdout.read().decode())

    s.close()

def bak_data():
    with open('Z:\\monitor_data\\bak_bm_file\\%s_结果.txt' %your_name, 'r+',encoding='utf-8') as f:
        for i in f:

            # resault = os.popen(" COPY %s  Z:\\monitor_data\\bak_bm_file\\%s\\ " %(i,your_name))
            # print(resault.read())
            if i:
                i=i.replace('\n','')
                name=i.split('\\')[-1]
                print(name)
                shutil.copyfile(i, 'Z:\\monitor_data\\bak_bm_file\\%s\\\%s' %(your_name,name))


def main():
    hostname = '192.168.0.62'
    port = 22
    username = 'root'
    password = 'Toprs!@#123'
    execmd = shell


    sshclient_execmd(hostname, port, username, password, execmd)

if __name__ == "__main__":
    main()

    bak_data()


