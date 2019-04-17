#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from 学习脚本 import module_test

print(module_test.say_hello())

module_test.logger()

from 学习脚本.module_test import name

print(name)
