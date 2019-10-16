#!/bin/sh
# 时间：2019-10-14
# 编写人：夏天
# 脚本描述：此脚本是把云平台环境中通过接口自动化创建的虚拟机的监控信息写入到MySQL数据库中

#清理MySQL数据表
mysql -h192.168.0.53 -uroot -p123456789 toprs -e "DELETE FROM tb_monitor_vm_copy;"
mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'truncate tb_monitor_vm_copy;'

#写入数据到MySQL中
for vm_name in `cat /mnt/monitor_data/temp_ip/vm_name.txt|awk '{print $1}'`
do


	#写入虚拟机CPU信息
	ip_address=$(cat /mnt/monitor_data/temp_ip/vm_name.txt|grep "$vm_name"|awk '{print $2}')
	cpu_info=$(/usr/lib/centreon/plugins/centreon_linux_snmp.pl --plugin=os::linux::snmp::plugin --mode=cpu --hostname="$ip_address" \
	--snmp-version='2c' --snmp-community='VSJPg7Gpm0Z08hbR' --warning='85' --critical='90'|cut -d'|' -f1|awk '{print $NF}')


	#写入内存信息
#	mem_info=$(python /data/scripts/monitor_data/remote_node.py "$ip_address"|awk '{print $4,$5}')


	#写入内存用量
	mem_use=$(/usr/lib/nagios/plugins/check_nt -H "$ip_address" -p 12489 -v MEMUSE -w 80 -c 90|cut -d'|' -f1|cut -d'-' -f2|awk '{print $NF}'|awk -F\( '{print $2}'|awk -F\) '{print $1}')

	
	#写入读IO值
	read_value=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f3|cut -d '=' -f2)
	read_time=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f5|cut -d'=' -f2)
	read_num=$(echo "scale=2;$read_value / $read_time / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	read_io="$read_num"


	#写入写IO值
	write_value=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f4|cut -d'=' -f2)
	write_time=$(python /data/scripts/monitor_data/remote_io.py "$ip_address"|awk -F\( '{print $2}'|cut -d',' -f6|cut -d'=' -f2|awk -F\) '{print $1}')
	write_num=$(echo "scale=2;$write_value / $write_time / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	write_io="$write_num"



	#接收带宽
	receive_band=$(python /data/scripts/monitor_data/remote_daikuan.py "$ip_address"|egrep "^Bytes"|awk '{print $2}')
	receive_value=$(echo "scale=2;$receive_band / 1024 / 1024"|bc| awk '{printf "%.2f", $0}')
	receive_num="$receive_value"


	#发送带宽
	send_band=$(python /data/scripts/monitor_data/remote_daikuan.py "$ip_address"|egrep "^Bytes"|awk '{print $3}')
	echo $send_band >>/tmp/send_band.txt
	dos2unix /tmp/send_band.txt &>/dev/null
	for s in `cat /tmp/send_band.txt`;do send_value=$(echo "scale=2;$s / 1024 / 1024"|bc| awk '{printf "%.2f", $0}');done
	send_num="$send_value"


	#写入MySQL表中的操作命令
	mysql_vm_name="INSERT tb_monitor_vm_copy(vm_name,cpu_use,memory_use,write_io,read_io,bandwidth_in,bandwidth_out) \
	VALUES('$vm_name','$cpu_info','$mem_use','$write_io','$read_io','$receive_num','$send_num');"
	mysql -h192.168.0.53 -uroot -p123456789 toprs -e "${mysql_vm_name}"

done
\rm -rf /tmp/send_band.txt


#比较数据表
for a1 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
	#比较新表有旧表没有
        n1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm where vm_name='$a1';"|wc -l)
        b1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select cpu_use from tb_monitor_vm_copy where vm_name='$a1';"|tail -1)
        c1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select memory_use from tb_monitor_vm_copy where vm_name='$a1';"|tail -1)
        d1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select write_io from tb_monitor_vm_copy where vm_name='$a1';"|tail -1)
        e1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select read_io from tb_monitor_vm_copy where vm_name='$a1';"|tail -1)
        f1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select bandwidth_in from tb_monitor_vm_copy where vm_name='$a1';"|tail -1)
        g1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select bandwidth_out from tb_monitor_vm_copy where vm_name='$a1';"|tail -1)
	j1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select memory_use from tb_monitor_vm where vm_name='ceshi-b3';"|tail -1)
	m1=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select write_io from tb_monitor_vm where vm_name='ceshi-b3';"|tail -1)
        [ $n1 -ne 2 ] && {
                h1="INSERT tb_monitor_vm(vm_name,cpu_use,memory_use,write_io,read_io,bandwidth_in,bandwidth_out) \
                VALUES('$a1','$b1','$c1','$d1','$e1','$f1','$g1');"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h1"
        }

	#比较新创建的虚拟机中,新表与旧表都有,旧表中信息为空
	[ -z $j1 ] && {
		k1="DELETE FROM  tb_monitor_vm WHERE vm_name='$a1';"
		u1="INSERT tb_monitor_vm(vm_name,cpu_use,memory_use,write_io,read_io,bandwidth_in,bandwidth_out) \
                VALUES('$a1','$b1','$c1','$d1','$e1','$f1','$g1');"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$k1"	
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$u1"	
	}

done

#比较旧表有新表没有
for a2 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm;'|egrep "^ceshi"`
do
        n2=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy where vm_name='$a2';"|wc -l)
        [ $n2 -eq 0 ] && {
                h2="DELETE FROM  tb_monitor_vm WHERE vm_name='$a2';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h2"
        }

done


#比较CPU
for a3 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
	n3=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy;"|egrep "^[0-9]"|grep "$a3"|awk '{print $3}')
	n3_copy=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"|egrep "^[0-9]"|grep "$a3"|awk '{print $3}')
        [ $n3 != ${n3_copy} ] && {
                h3="UPDATE tb_monitor_vm SET cpu_use='$n3' WHERE vm_name='$a3';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h3"
        }

done

#比较内存用量
for a4 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
        n4=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy;"|egrep "^[0-9]"|grep "$a4"|awk '{print $5}')
        n4_copy=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"|egrep "^[0-9]"|grep "$a4"|awk '{print $5}')
        [ $n4 != ${n4_copy} ] && {
                h4="UPDATE tb_monitor_vm SET memory_use='$n4' WHERE vm_name='$a4';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h4"
        }

done

#比较写IO
for a5 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
        n5=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy;"|egrep "^[0-9]"|grep "$a5"|awk '{print $6}')
        n5_copy=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"|egrep "^[0-9]"|grep "$a5"|awk '{print $6}')
        [ $n5 != ${n5_copy} ] && {
                h5="UPDATE tb_monitor_vm SET write_io='$n5' WHERE vm_name='$a5';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h5"
        }

done

#比较读IO
for a6 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
        n6=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy;"|egrep "^[0-9]"|grep "$a6"|awk '{print $7}')
        n6_copy=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"|egrep "^[0-9]"|grep "$a6"|awk '{print $7}')
        [ $n6 != ${n6_copy} ] && {
                h6="UPDATE tb_monitor_vm SET read_io='$n6' WHERE vm_name='$a6';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h6"
        }

done

#比较入口带宽
for a7 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
        n7=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy;"|egrep "^[0-9]"|grep "$a7"|awk '{print $8}')
        n7_copy=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"|egrep "^[0-9]"|grep "$a7"|awk '{print $8}')
        [ $n7 != ${n7_copy} ] && {
                h7="UPDATE tb_monitor_vm SET bandwidth_in='$n7' WHERE vm_name='$a7';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h7"
        }

done

#比较出口带宽
for a8 in `mysql -h192.168.0.53 -uroot -p123456789 toprs -e 'select vm_name from tb_monitor_vm_copy;'|egrep "^ceshi"`
do
        n8=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm_copy;"|egrep "^[0-9]"|grep "$a8"|awk '{print $9}')
        n8_copy=$(mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"|egrep "^[0-9]"|grep "$a8"|awk '{print $9}')
        [ $n8 != ${n8_copy} ] && {
                h8="UPDATE tb_monitor_vm SET bandwidth_out='$n8' WHERE vm_name='$a8';"
                mysql -h192.168.0.53 -uroot -p123456789 toprs -e "$h8"
        }

done

