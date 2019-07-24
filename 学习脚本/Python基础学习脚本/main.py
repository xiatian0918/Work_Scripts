#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


#导入指定路径模块

def main():
    from auto_scripts.学习脚本.Python基础学习脚本 import module_test
    print(module_test.say_hello())
    module_test.logger()

    from auto_scripts.学习脚本.Python基础学习脚本.module_test import name
    print(name)

if __name__ == '__main__':
    main()

