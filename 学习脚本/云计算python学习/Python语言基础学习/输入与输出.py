#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# Take input from user
str_1 = input("Enter a string: ")
str_2 = input("Enter another string: ")

# Output the strings
print("str_1 is: %s   str_2 is: %s" %(str_1,str_2))

# 文件操作
some_sentences = '''
I love learning python
because python is fun
and also easy to use
'''

# Open for 'w'irting
f = open('sentences.txt','w')
#write text to file
f.write(some_sentences)
f.close()

#If not specifying node, 'r'ead mode is default
f = open("sentences.txt")
while True:
    line = f.readline()
    if len(line) == 0:
        break
    print(line.strip())
# close the File
f.close()