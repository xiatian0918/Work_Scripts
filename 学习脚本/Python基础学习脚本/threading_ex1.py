#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import threading,time

# print(time.time())
def run(n):
    print("task",n)
    time.sleep(2)

t1 = threading.Thread(target=run,args=("t1",))
t2 = threading.Thread(target=run,args=("t2",))

t1.start()
t2.start()

# run("t1")
# run("t2")


def main():
    print("hehe")

if __name__ == '__main__':
     main()
