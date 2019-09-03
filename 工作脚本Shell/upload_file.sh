#!/bin/sh
# 时间：2019-07-23
# 编写人：夏天
# 描述：这是一个文件上传脚本，通过nginx代理上传站点

file=$1

curl -sXPOST -F "file=@"$1"" -H "Cookie:http://192.168.0.59:5000/v3" http://192.168.0.59/upload;echo ""

new_name=$(basename $file)
old_name=$(ls -l /mnt/development/upload/|tail -1|awk '{print $NF}')
#echo $new_name
#echo $old_name
mv /mnt/development/upload/"$old_name" /mnt/development/upload/$new_name
