#!/bin/sh


/usr/bin/php  /root/session.php >/tmp/session2_id.txt
session2=$(tail -1 /tmp/session2_id.txt)

curl -ksX GET --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" 'https://192.168.0.24/rest/vcenter/vm'|jq . >/tmp/vmware_host.txt

cd /tmp/

cat vmware_host.txt |egrep "name|vm"|cut -d',' -f1|awk 'NR%2'|cut -d':' -f2|awk -F\" '{print $2}' >vmware_name
cat vmware_host.txt |egrep "name|vm"|cut -d',' -f1|awk '!(NR%2)'|cut -d':' -f2|awk -F\" '{print $2}' >vmware_vm

awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]" "$0;j++}' vmware_name vmware_vm >vmware_name.txt

rm -rf vmware_name vmware_vm vmware_host.txt

read -t 10 -p "请输入您要对电源状态更改的虚拟机IP：" host
if [ -z $host ];then
#        echo ""
        exit 1
fi

vm_name=$(cat /tmp/vmware_name.txt |grep $host|awk '{print $2}')
curtime=$(curl -ksX GET --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm/${vm_name}/power"|jq .|grep state|cut -d':' -f2|awk -F\" '{print $2}')  


echo "当前该虚拟机的电源状态为：${curtime}"
#echo -e "\033[43;35m 当前该虚拟机的电源状态为：${curtime}  \033[0m \n"

read -t 10 -p "请输入您要对该虚拟机电源状态更改为(reset|start|stop)：" state

if [ -z $state ];then 
#	echo ""
	exit 1
fi
echo "******************************************************************"
echo -e "\033[41;37m        请耐心等待，正在处理中.............       \033[0m"
echo "******************************************************************"
sleep 1

case $state in
	
 reset)
	curl -ksX POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm/${vm_name}/power/reset" &>/dev/null 
	if [ $? -eq 0 ];then
		echo "虚拟机:${host},当前电源状态已更改为:${state}"
		exit 2
	else
		echo "虚拟机:${host},当前电源状态更改失败!"
		exit 2
	fi
 ;;
 
 start)
	curl -ksX POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm/${vm_name}/power/start" &>/dev/null
	if [ $? -eq 0 ];then 
                echo "虚拟机:${host},当前电源状态已更改为:${state}"
                exit 2
        else
                echo "虚拟机:${host},当前电源状态更改失败!"
                exit 2
        fi
 ;;

 stop)
	curl -ksX POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header "vmware-api-session-id:${session2}" "https://192.168.0.24/rest/vcenter/vm/${vm_name}/power/stop" &>/dev/null
	if [ $? -eq 0 ];then
                echo "虚拟机:${host},当前电源状态已更改为:${state}"
                exit 2
        else
                echo "虚拟机:${host},当前电源状态更改失败!"
                exit 2
        fi
 ;;

 *)

	echo -e "\033[47;30m  请输入要更改的虚拟机电源状态，可选择为(reset|start|stop) \033[0m"
esac
