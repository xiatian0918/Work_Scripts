#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

try:
    open('test')
    data = 'fsdf'

except Exception as e:  #出错会执行
    print('hrhr',e)


else:   #未出现错误会执行
    print("haha")

# finally:   #不管这么样，都会执行
# #     print('woca')


