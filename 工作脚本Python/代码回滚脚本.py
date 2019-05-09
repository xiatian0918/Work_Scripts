from datetime import datetime
import paramiko, time


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


a = datetime.now()
for i in range(0, 3):
    if i == 0:
#        print(i)
        shell = "ssh 192.168.0.63 '/bin/sh /root/code_show.sh'"  # 显示版本日期的脚本
        main()
    if i == 1:
        code_name = input("请输入要回滚的代码日期版本：")
        shell = "ssh 192.168.0.63 '/bin/sh /root/code_back.sh %s >/tmp/1.txt' " % code_name
        main()
    if i == 2:
        shell = "ssh 192.168.0.63 'cat /tmp/1.txt'"
        main()
b = datetime.now()
print('耗时：', b - a)
