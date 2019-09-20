#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# Example of Syntax errors
while True print("Hello world!")

# Example of exceptions
print(hello*4)
print(8/0)

# 异常处理
while True:
    try:
        x = int(input("Please enter a number: "))
        break
    except ValueError:
        print("Not valid input, try again ...")

try:
    f = open("myfile.txt")
    s = f.readline()
    i = int(s.strip())
except OSError as err:
    print("OS error: %s" %err)
except ValueError:
    print("Could not convert data to an integer.")

