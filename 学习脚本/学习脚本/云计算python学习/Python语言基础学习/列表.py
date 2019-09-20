#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# print("您好！")
#
# print("what's your name?\nTom" )

# 创建 list
number_list = [1,3,5,7,9]
# print("number_list：",number_list)

string_list = ["abc", "bbc", "python"]
mixed_list = ["python", "java", 3, 12]
#
# print("string_list: %s" %string_list)
# print("mixed_list: ",mixed_list)

# 访问列表中的元素
second_num = number_list[1]
third_string = string_list[2]
fourth_mixed = mixed_list[3]

# print("second_num: " + str(second_num) )
# print("third_string: {0}".format(third_string))
# print("fourth_mixed: %s" %fourth_mixed)

# print("second_num: %s  ,third_string: %s  ,fourth_mixed: %s " %(second_num,third_string,fourth_mixed))

# 更新列表中的元素
number_list[1] = 30
# print("number_list after:",number_list)

# 删除列表中的元素
del number_list[1]
# print("number_list after del: " ,number_list)

# 追加列表中的元素
number_list.append("fdsfds")
number_list.insert(0,"xiatian")
print(number_list)
