#!/usr/bin/env python
#-*- coding:utf-8 -*-

import datetime
import os


def copy_file(linux_path, window_path):
    # 判断文件夹存在否
    if os.path.isdir( r"E:\hehe"):
        for root, dirs, files in os.walk(r"E:\hehe"):  # 目录
            for f in files:
                os.remove(os.path.join(root, f))  # 文件删除
    # 目录复制
    t1 = datetime.datetime.now()
    os.system("xcopy /s %s %s" % (linux_path, window_path))
    t2 = datetime.datetime.now()
    t = t2 - t1
    return t


def getFileSize(filePath, size=0, count=0):
    if os.path.isfile(filePath):  # 文件
        return os.path.getsize(filePath)
    for root, dirs, files in os.walk(filePath):  # 目录
        for f in files:
            count += 1
            size += os.path.getsize(os.path.join(root, f))  # 文件大小累加
            os.remove(os.path.join(root, f))  # 文件删除
    # os.remove(filePath)
    return size / 1024 / 1024  # 目前单位为MB


def main():
    linux_path = r"Z:\测试001\projectname_test\Images"
    window_path = r"E:\hehe"

    t = copy_file(linux_path, window_path)
    size = getFileSize(window_path)
    if t.seconds == 0:
        speed = 'fail'
    else:
        speed = size / t.seconds
    try:
        os.remove(r'C:\result.txt')
    except:
        pass
    with open(r'C:\result.txt','w+') as f:
        f.write('耗时：%s 秒;\n文件大小为：%0.2f MB ;\n传输速度为：%0.2f mb/s' % (t, size, speed))


if __name__ == '__main__':
    main()
