#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import sys
a = 3
b = 4

c = 5.66
d = 8.0

e = complex(c,d)
f = complex(float(a),float(b))

print("a is type:",type(a))
print("c is type:",type(c))
print("e is type:",type(e))

print(a + b)
print(d / c)

print(b / a)
print(b // a)

print(e)
print(f)
print(e + f)

print(sys.float_info)

