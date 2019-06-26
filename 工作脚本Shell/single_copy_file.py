#!/home/ymserver/virtualenv/dj/bin/python
#coding:utf-8


import datetime
import os


def copy_file(linux_path, window_path):
    # 判断文件夹存在否
    if not os.path.isdir(window_path):
        os.mkdir(r"C:\\data1")

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
    return size / 1024 / 1024  # 目前单位为MB


def main():
    linux_path = r"Z:\data1"
    window_path = r"C:\\data1"

    t = copy_file(linux_path, window_path)
    size = getFileSize(window_path)
    if t.seconds == 0:
        speed = '耗时太短，无法检测'
    else:
        speed = size / t.seconds
    print('耗时：%s 秒;\n文件大小为：%0.2f MB;\n传输速度为：%s mb/s' % (t, size, speed))


if __name__ == '__main__':
    main()
