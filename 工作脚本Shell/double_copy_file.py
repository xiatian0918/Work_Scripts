# import datetime
# import os
# import time
#
#
# def copy_file(linux_path, window_path):
#     # 判断文件夹存在否
#
#     os.mkdir(window_path)
#     # 目录复制
#     t1 = datetime.datetime.now()
#     os.system("xcopy /s %s %s" % (linux_path, window_path))
#     t2 = datetime.datetime.now()
#     t = t2 - t1
#     return t
#
#
# def getFileSize(filePath, size=0, count=0):
#     if os.path.isfile(filePath):  # 文件
#         return os.path.getsize(filePath)
#     for root, dirs, files in os.walk(filePath):  # 目录
#         for f in files:
#             count += 1
#             size += os.path.getsize(os.path.join(root, f))  # 文件大小累加
#             os.remove(os.path.join(root, f))  # 文件删除
#         os.rmdir(filePath)
#     return size / 1024 / 1024  # 目前单位为MB
#
#
# def main():
#     linux_path = r"Z:\data1"
#     window_path = r"C:\data1"
#
#     t = copy_file(linux_path, window_path)
#     size = getFileSize(window_path)
#     if t.seconds == 0:
#         speed = 'so short'
#     else:
#         speed = size / t.seconds
#     # print('First ：%s seconds;\nSize ：%0.2f MB ;\nSpeed ：%0.2f mb/s' % (t, size, speed))
#     return speed
#
#
# def main2():
#     linux_path = r"Z:\data2"
#     window_path = r"E:\data2"
#
#     t = copy_file(linux_path, window_path)
#     size = getFileSize(window_path)
#     if t.seconds == 0:
#         speed = 'so short'
#     else:
#         speed = size / t.seconds
#     # print('Second ：%s seconds;\nSize ：%0.2f MB ;\nSpeed ：%0.2f mb/s' % (t, size, speed))
#     return speed
#
#
# if __name__ == '__main__':
#     speed1 = main()
#     print('\n——————————————————sleep———————————————————————\n')
#     time.sleep(5)
#     speed2 = main2()
#     speed = (speed1 + speed2) / 2
#     print('mid:%0.2f mb/s' % speed)

import datetime
import os
import time, multiprocessing, threading


def copy_file(linux_path, window_path):
    # 判断文件夹存在否

    os.mkdir(window_path)
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
        os.rmdir(filePath)
    return round(size / 1024 / 1024)  # 目前单位为MB


def main():
    linux_path = r"Z:\data1"
    window_path = r"C:\data1"

    t = copy_file(linux_path, window_path)
    size = getFileSize(window_path)
    if t.seconds == 0:
        speed = 'so short'
    else:
        speed = size / t.seconds
    # print('First ：%s seconds;\nSize ：%0.2f MB ;\nSpeed ：%0.2f mb/s' % (t, size, speed))

    with open(r"C:\info.txt", 'a+') as f:
        a = str(size) + ' '
        print(a)
        f.write(a)
        f.close()
    with open(r"C:\info1.txt", 'a+') as f1:
        a = str(t.seconds) + ' '
        print(a)
        f1.write(a)
        f1.close()
    return speed


def main2():
    linux_path = r"Z:\data2"
    window_path = r"E:\data2"

    t = copy_file(linux_path, window_path)
    size = getFileSize(window_path)
    if t.seconds == 0:
        speed = 'so short'
    else:
        speed = size / t.seconds
    # print('Second ：%s seconds;\nSize ：%0.2f MB ;\nSpeed ：%0.2f mb/s' % (t, size, speed))

    with open(r"C:\info.txt", 'a+') as f:
        a = str(size) + ' '
        print(a)
        f.write(a)
        f.close()
    with open(r"C:\info1.txt", 'a+') as f1:
        a = str(t.seconds) + ' '
        print(a)
        f1.write(a)
        f1.close()
    return speed


if __name__ == '__main__':
    # 多线程
    pool = threading.Thread(target=main2)
    pool1 = threading.Thread(target=main)

    pool.start()
    pool1.start()
    pool.join()
    pool1.join()
    with open(r"C:\info.txt", 'r') as f:
        a = f.readlines()
        a = a[0].split(' ')
    with open(r"C:\info1.txt", 'r') as f:
        b = f.readlines()
        b = b[0].split(' ')
        size_total = int(a[0]) + int(a[1])
        if int(b[0]) >= int(b[1]):
            speed2 = size_total / int(b[0])
        else:
            print(size_total, int(b[1]))
            speed2 = size_total / int(b[1])

    print('速度为:', speed2)
    os.remove(r"C:\info.txt")
    os.remove(r"C:\info1.txt")

    # 多进程
    # pool = multiprocessing.Pool(processes=2)
    # a = pool.apply_async(main)
    # b = pool.apply_async(main2)
    # print(a,b)
    # pool.close()
    # pool.join()

    # 串行
    # speed1 = main()
    # print('\n——————————————————sleep———————————————————————\n')
    # time.sleep(5)
    # speed2 = main2()
    # speed = (speed1 + speed2) / 2
    # print('mid:%0.2f mb/s' % speed)
    # os.remove(r"C:\info.txt")
    # os.remove(r"C:\info1.txt")
