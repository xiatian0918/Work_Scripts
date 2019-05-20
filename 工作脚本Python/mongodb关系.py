#!/usr/bin/env/python

import paramiko

shell = "/bin/python /usr/lib/nagios/plugins/nagios-plugin-mongodb/check_mongodb.py \
         -H 192.168.0.59 -A replset_state -P 27019"

def sshclient_execmd(hostname, port, username, password, execmd):
    paramiko.util.log_to_file("paramiko.log")

    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    s.connect(hostname=hostname, port=port, username=username, password=password)
    stdin, stdout, stderr = s.exec_command(execmd)
    stdin.write("Y")  # Generally speaking, the first connection, need a simple interaction.

    print
    stdout.read()

    s.close()


def main():
    hostname = '192.168.0.64'
    port = 22
    username = 'xiatian'
    password = '123456'
    execmd = shell


    sshclient_execmd(hostname, port, username, password, execmd)


if __name__ == "__main__":
    main()
