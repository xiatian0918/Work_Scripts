#!/bin/bash
#此脚本是自动化检查虚拟化设备的电源状态，并自动重启

#虚拟化计算节点ip地址
vm_exsi_ip=(
'192.168.0.38'
'192.168.0.39'
'192.168.0.40'
)

#找出指定计算节点测试服务ip和端口
<<COMMENT
192.168.0.21(192.168.0.38)
192.168.0.61 22
192.168.0.64 22
192.168.0.85 3389

192.168.0.22(192.168.0.39)
192.168.0.52 22
192.168.0.62 22
192.168.0.71 22

192.168.0.23(192.168.0.40)
192.168.0.24 3389
192.168.0.51 22
192.168.0.67 22
COMMENT

cat >>/tmp/server_port.txt<<EOF
192.168.0.61 22
192.168.0.64 22
192.168.0.85 3389
192.168.0.52 22
192.168.0.62 22
192.168.0.71 22
192.168.0.24 3389
192.168.0.51 22
192.168.0.67 22
EOF

#测试服务端口是否正常，如不正常重启虚拟化计算节点
cat /tmp/server_port.txt|while read i
do
	nc -vz -w 2 $i &>/dev/null
	
	if [ $? -ne 0 ];
	then
	    no_correct=$(echo $i|awk '{print $1}')
	    if [ $no_correct == "192.168.0.61" -o $no_correct == "192.168.0.64" -o $no_correct == "192.168.0.85" ];then
		ipmitool -I lanplus -H 192.168.0.38 -U admin -P admin chassis power reset
            elif [ $no_correct == "192.168.0.52" -o $no_correct == "192.168.0.62" -o $no_correct == "192.168.0.71" ];then
                ipmitool -I lanplus -H 192.168.0.39 -U admin -P admin chassis power reset
            elif [ $no_correct == "192.168.0.24" -o $no_correct == "192.168.0.51" -o $no_correct == "192.168.0.67" ];then
                ipmitool -I lanplus -H 192.168.0.40 -U admin -P admin chassis power reset
            fi
	fi
	
done

#删除服务端口记录文件
\rm -rf /tmp/server_port.txt
