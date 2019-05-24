#!/bin/sh

read -t 25 -p "请输入你要添加的用户名: " user
echo "**************************************"

[ -z $user ] && {
	echo "用户名不能为空，请输入用户名"
	exit 2
}

a=`echo $user |grep [^a-zA-Z] |wc -l`
[ $a -ne 0 ] && {
	echo "请输入合法的用户名"
	exit 3
}

useradd $user

su $user -s /bin/sh -c "ssh-keygen -t rsa -P 'Toprs!@#123' -f /home/${user}/${user}_rsa"
su $user -s /bin/sh -c "mkdir -p /home/$user/.ssh -p"
su $user -s /bin/sh -c "cat /home/$user/${user}_rsa.pub >> /home/$user/.ssh/authorized_keys"
su $user -s /bin/sh -c "chmod 600 /home/$user/.ssh/authorized_keys"
su $user -s /bin/sh -c "chmod 700 /home/$user/.ssh/"

mkdir -p /usr/share/nginx/html/$user/
cp -r /home/$user/${user}_rsa /usr/share/nginx/html/$user/
