#!/bin/sh
######################################################################### 
# File Name: check_haproxy.sh 
# Author: jc 
# Created Time: 2014年03月01日 星期六 14时36分23秒 
######################################################################### 
#!/bin/bash 
#定义返回状态 
ST_OK=0 
ST_WR=1 
ST_CR=2 
ST_UK=3 
#sock的默认路径 
sock_path=/var/lib/haproxy/stats
#默认检查sock是否存在 
#sock_check=1 
#帮助信息函数 
print_help() { 
    echo "  --sock|-s)"
    echo "    haproxy的sock路径，默认路径:/var/lib/haproxy/stats"
    echo "  -m/--mode)"
    echo "    haproxy的状态项,目前只支持:rate,ereq,econ,eresp,status"
#    echo "  -n/--no-check-sock)" 
#    echo "    检查sock存在与否，1检查，0不检查" 
    exit $ST_UK 
} 
#获取输入的选项 
while test -n "$1"; do
    case "$1" in
        -help|-h) 
        print_help 
        exit $ST_UK 
        ;; 
        --sock|-s) 
        sock=$2 
        shift
        ;; 
        --mode|-m) 
        mode=$2 
        shift
        ;; 
        --no-sock-check|-n) 
        sock_check=0 
        ;; 
        --hostname|-H) 
        hostname=$2 
        shift
        ;; 
        --warning|-w) 
        warning=$2 
        shift
        ;; 
        --critical|-c) 
        critical=$2 
        shift
        ;; 
        *) 
        echo "Unknown argument: $1"
        print_help 
        exit $ST_UK 
        ;; 
  esac
  shift
done
#sock检测 
#check_sock() { 
#echo "show stat" | socat /var/lib/haproxy/stats stdio >/tmp/hap_sta.txt 
#if [ -s "/tmp/hap_sta.txt" ] 
#then 
#        con=1 
#else 
#        con=2 
#fi 
#} 
#获取数据 
get_val() { 
case $mode in
        rate) 
                val=`echo "show stat" | socat $sock_path stdio | awk -F, '$2=="web1" {print $34}'` 
                ;; 
        ereq) 
                val=`echo "show stat" | socat $sock_path stdio | awk -F, '$2=="web1" {print $13}'` 
                if [ -z $val ] 
            then
            val=0 
            fi
            ;; 
        econ) 
                val=`echo "show stat" | socat $sock_path stdio | awk -F, '$2=="web1" {print $14}'` 
                ;; 
        eresp) 
                val=`echo "show stat" | socat $sock_path stdio | awk -F, '$2=="web1" {print $15}'` 
                ;; 
        status) 
                val=`echo "show stat" | socat $sock_path stdio | awk -F, '$2=="web1" {print $18}'` 
                ;; 
        *) 
        echo "暂时不能检测此项，请重新输入"
        ;; 
esac
} 
#显示的文字信息 
out_pr() { 
output="haproxy is running. $mode's key is $val"
} 
#开始执行 
##检查sock是否能够连上 
#if [ $sock_check = 1 ] 
#then 
#    check_sock 
#    if [ "$con" = 2 ] 
#    then 
#        echo "ERR!!连接haproxy被拒绝，请确认服务已经开启，或者检查sock路径/权限是否正确！" 
#        exit $ST_CR 
#    fi 
#fi 
get_val 
out_pr 
#get_stat() { 
if [[ "$val" -ge "$warning" ]] && [[ "$val" -lt "$critical" ]]
then
        echo "WARNING - $output"
        exit $ST_WR 
elif [[ "$val" -ge "$critical" ]]
then
        echo "CRITICAL - $output"
        exit $ST_CR 
else
        echo "OK - $output"
        exit $ST_OK 
fi
