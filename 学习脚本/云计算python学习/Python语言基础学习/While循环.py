#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

# while循环示例
number = 59
guess_flag = False

while guess_flag == False:
    guess = int(input("Enter an integer: "))
    if guess == number:
        guess_flag = True
    elif guess < number:
        print("No, the number is higher than that, keep guessing")
    else:
        print("No, the number is a lower than that, keep guessing")

print("Bingo! you guessed it right.")
print("(but you do not win any prizes!)")
print("Done")

# 3次机会猜数字 for
number =59
num_chances = 3
print("you have only 3 chances to guess")

for i in range(1,num_chances + 1):
    print("chances ",i)
    guess = int(input("Enter an integer: "))
    if guess == number:
        print("Bingo! you guessed it right.")
        print("(but you do not win any prizes!)")
        break

    elif guess < number:
        print("No, the number is higher than that, keep guessing, you have %s chances left" %(num_chances - i))
    else:
        print("No, the number is a lower than that, keep guessing, you have %s chances left" %(num_chances - i))

print("Done")

# break & continue example:
number = 59
while True:
    guess = int(input("Enter an integer: "))
    if guess == number:
        break
    elif guess < number:
        print("No, the number is higher than that, keep guessing")
        continue
    else:
        print("No, the number is a lower than that, keep guessing")
        continue

print("Bingo! you guessed it right.")
print("(but you do not win any prizes!)")
print("Done")

# continue and pass difference
a_list = [0,1,2]

print("using continue:")
for i in a_list:
    if not i:
        continue
    print(i)

print("using continue:")
for i in a_list:
    if not i:
        pass
    print(i)
