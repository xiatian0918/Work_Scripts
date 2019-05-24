#!/bin/bash
#author: zeping lai
#检查磁盘io使用率
#使用: ./check_disk_io_all.sh sda
 
if [ $# -ne 1 ];then
   echo 'Usage: '$0 '$dev'
   exit 3
else
   dev=$1
fi
 
#磁盘设备
#dev=sda
 
#设定告警值
#磁盘使用率,该参数100%表示设备已经接近满负荷运行了
sw_util=80
 
#多少秒内的状态,也决定了这个脚本需在执行多长时间
num=3
 
#临时文件 
tmp=/tmp/check_dis_io_$$.tmp
 
#采集数据
/usr/bin/iostat -d -x -k 1 $num |grep $dev >> $tmp
 
#行数
rows=`cat $tmp|wc -l`
 
if [ $num -eq $rows ];then
 
    #列求和
    sum_read=`awk '{sum+=$6}END{print sum}' $tmp`
    sum_wrtn=`awk '{sum+=$7}END{print sum}' $tmp`
    sum_await=`awk '{sum+=$10}END{print sum}' $tmp`
    sum_util=`awk '{sum+=$12}END{print sum}' $tmp`
    
    #算平均值
    read=$(echo $sum_read $rows |awk '{print $1/$2}')
    wrtn=$(echo $sum_wrtn $rows |awk '{print $1/$2}')
    await=$(echo $sum_await $rows |awk '{print $1/$2}')
    util=$(echo $sum_util $rows |awk '{print $1/$2}')
    
    util_int=$(echo "$util / 1"|bc)
    rm -rf $tmp
 
    #超过使用设定值则告警
    if [ $sw_util -gt $util_int ]; then
        echo "OK await:$await, util:$util|read=${read}KB;wrtn=${wrtn}KB;await=$await;util=$util"
        exit 0
    else
        echo "Warning await:$await, util:$util|read=${read}KB;wrtn=${wrtn}KB;await=$await;util=$util"
        exit 1    
    fi
 
else
    rm -rf $tmp
       echo "Error !  check_disk_io failure ！"
       exit 3 
fi
