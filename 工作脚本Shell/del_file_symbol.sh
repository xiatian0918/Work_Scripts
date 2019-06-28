#!/bin/sh

read -t 20 -p "请输入你要清理特殊字符的文件(请填写绝对路径): " file_base

[ -z $file_base ] && {
	echo "请填写正确的文件名,已退出此操作"
	exit 1
}

expr $file_base + 1 &>/dev/null
[ $? -eq 0 ] && {
	echo "请填写正确的文件名,已退出此操作"
        exit 2
}

sed -i 's%\r%%g' $file_base &>/dev/null
[ $? -eq 0 ] && {
	echo "文件格式转换已经成功"
	exit 0
}
