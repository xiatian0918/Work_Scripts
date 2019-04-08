#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

count = 0
while True:
    price = int(input("请输入价格:" ) )
    if price == 50:
        print("恭喜你猜对了")
        exit(2)
    elif price > 50:
        print("你猜的价格高了")
    elif price < 50:
      print("你猜的价格低了")
    count +=1
    if count == 4:
        exit(4)