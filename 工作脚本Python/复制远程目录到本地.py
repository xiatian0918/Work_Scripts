#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import sys, os, re


def copyFileDir(srcFilename, desFilename):
    status = False
    try:
        fileList = os.listdir(srcFilename)
        for eachFile in fileList:
            sourceF = os.path.join(srcFilename, eachFile)
            targetF = os.path.join(desFilename, eachFile)

            if os.path.isdir(sourceF):
                if not os.path.exists(targetF):
                    os.makedir(targetF)
                status = copyFileDir(sourceF, targetF)
            else:
                status = copyFile(sourceF, targetF)
    except Exception as  e:
        print(e)
        status = False
    finally:
        print('copyFileDir function is quit!')
    return status


def copyFile(srcFilename, desFilename):
    status = False
    copyCommand = 'copy %s %s' % (srcFilename, desFilename)

    try:
        if (os.popen(copyCommand)):  # 不用op.system(copyCommand),因为这个会弹出命令行界面
            print('copy done!')
            status = True
        else:
            print('copy failed!')
            status = False
    except Exception as e:
        print(e)
        status = False
    finally:
        print('copyFile function is quit!')
    return status


def copyFromSharePath(srcFilename, desFilename):
    if not os.path.exists(srcFilename):
        print('no found ' + srcFilename)
        return False
    if not os.path.exists(desFilename):
        print('no found ' + desFilename)
        os.makedirs(str(desFilename))
        print('create ' + desFilename)

    copyStatus = False
    if os.path.isdir(srcFilename):
        copyStatus = copyFileDir(srcFilename, desFilename)
    else:
        copyStatus = copyFile(srcFilename, desFilename)
    return copyStatus


def main(argv=sys.argv):
    if not len(argv) == 3:
        print('input parameters\'s count should be 3,not %s' % (len(argv)))
        return
    print(u'脚本名字是：' + argv[0])
    srcFilename = argv[1]
    print(u'源目录：' + argv[1])
    desFilename = argv[2]
    print(u'目标目录：' + argv[2])

    if os.path.isdir(srcFilename):
        if os.path.isfile(desFilename):
            print('can not copy a folder to a file')
            return
    copyFromSharePath(srcFilename, desFilename)


if __name__ == '__main__':
    hostIp = '192.168.0.29'
    sharePath = '\Toprs-rd3-60T\development'
    filename = 'testfile2.txt'

    resultStr = []
    resultStr.append([])
    srcFilename = '\\\\' + hostIp + sharePath + '\\' + filename
    desFilename = 'C:\\zabbix'

    cmd = [
        'E:\Python\auto_scripts\工作脚本Python\复制远程目录到本地.py',
        srcFilename,
        desFilename
    ]
    main(cmd)
    print('ok')
