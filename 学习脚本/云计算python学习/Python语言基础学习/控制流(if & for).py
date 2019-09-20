#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


# if判断语句
number = 59
guess = int(input("Enter an integer: "))
#print("guess is: ",guess)

if guess == number:
    # New block starts here
    print("Bingo! you guessed it right.")
    print("(but you do not win any prizes!)")
    # New block ends here
elif guess < number:
    # Another block
    print("No, the number is higher than that ")
    # You can do whatever you want in a block ...
else:
    print("No, the number is a lower than that")
    # you must have guessed > number to reach here
print("Done")



# for循环示例
for i in range(1,10):
    print(i)
else:
    print('The for loop is over')

a_list = [1,3,5,7,9]
for i in a_list:
    print(i)

a_tuple = (1,3,5,7,9)
for i in a_tuple:
    print(i)

a_dict = {'Tom':'111',
          'Jerry':'222',
          'Cathy':'333'}
for i in a_dict:
    print(i)
    print(a_dict[i])

for key, value in a_dict.items():
    print(key,value)


