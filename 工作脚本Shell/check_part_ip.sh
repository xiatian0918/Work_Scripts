#!/bin/bash
# 时间：2019-09-03
# 编写人：夏天
# 描述：此脚本是获取除去自动化IP地址外的信息

# 清空文件中的内容
[ -f "/mnt/monitor_data/temp_ip/part_ip.txt" ] && cat /dev/null >/mnt/monitor_data/temp_ip/part_ip.txt


# IP地址池
# 192.168.0.{91..110}
# 获取总的存活IP
for i in 192.168.0.{91..110};
do 
	/usr/lib/nagios/plugins/check_icmp $i &>/dev/null
	[ $? -eq 0 ] && echo $i >>/mnt/monitor_data/temp_ip/total_ip.txt
done


# 获取总IP与自动化创建的相同IP地址

for a in `cat /mnt/monitor_data/vm_ip/vm_vm_ip.txt`;
do 
	exis=$(cat /mnt/monitor_data/temp_ip/total_ip.txt|grep $a|wc -l)
	[ $exis -ne 0 ] && echo $a >>/mnt/monitor_data/temp_ip/exis_ip.txt 
done


# 筛选除去数据库中自动化创建的IP地址
cat /mnt/monitor_data/temp_ip/total_ip.txt | sort | uniq | sort > /mnt/monitor_data/temp_ip/a_u.txt
cat /mnt/monitor_data/temp_ip/exis_ip.txt | sort | uniq | sort > /mnt/monitor_data/temp_ip/b_u.txt
comm -23 /mnt/monitor_data/temp_ip/a_u.txt /mnt/monitor_data/temp_ip/b_u.txt > /mnt/monitor_data/temp_ip/part_ip.txt

# 删掉存在文本
\rm -rf /mnt/monitor_data/temp_ip/total_ip.txt
\rm -rf /mnt/monitor_data/temp_ip/exis_ip.txt
\rm -rf /mnt/monitor_data/temp_ip/a_u.txt
\rm -rf /mnt/monitor_data/temp_ip/b_u.txt

# 获取与vm_name文件相同的虚拟机名称和IP
[ -f "/mnt/monitor_data/temp_ip/vm_info.txt" ] && \rm -rf /mnt/monitor_data/temp_ip/vm_info.txt
for s in `cat /mnt/monitor_data/temp_ip/part_ip.txt`;do cat /mnt/monitor_data/temp_ip/vm_name.txt|grep $s >>/mnt/monitor_data/temp_ip/vm_info.txt;done

# 写入数据到mysql中
#mysql -h '192.168.0.53' -u 'root' -p'123456789' -e 'use toprs;truncate table tb_template_vm;'
db_name="toprs"

cat /mnt/monitor_data/temp_ip/vm_info.txt|while read my_data
do
	vm_name_info=$(echo $my_data |awk '{print $1}')
	vm_ip_info=$(echo $my_data |awk '{print $2}')
	ip_info=$(echo $vm_ip_info|awk -F. '{printf "%d\n", ($1*(2^24))+($2*(2^16))+($3*(2^8))+$4}')
	comm="insert into tb_template_vm (vm_name,vm_ip) values('${vm_name_info}',${ip_info})"
	select_data=$(mysql -h '192.168.0.53' -u 'root' -p'123456789' -e 'use toprs;select * from tb_template_vm;'|grep "$vm_name_info")
	if [ -z ${select_data} ];then
		mysql -h 192.168.0.53 -uroot -p123456789 ${db_name} -e"${comm}"
	fi
done

mysql -h '192.168.0.53' -u 'root' -p'123456789' -e 'use toprs;select * from tb_template_vm;'

