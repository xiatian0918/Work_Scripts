#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from tkinter import *

import tkinter.simpledialog as dl
import tkinter.messagebox as mb

# root = TK()
# w = Label(root,text = "Label title")
# w.pack()

mb.showinfo("Welcome","Welcome to Guess Number Game")
# mb.showinfo("Welcome","Welcome Message")
# guess = dl.askinteger("Number", "Enter a number")
#
# output = "This is output message"
# mb.showinfo("Output: ",output)

number = 59
while True:
    guess = dl.askinteger("Enter an integer: ")
    if guess == number:
        output = "bingo! you guessed it right, but you do not win any prizes!"
        mb.showinfo("Hint: ",output)
        break
    elif guess < number:
        output = "No, the number is higher than that"
        mb.showinfo("Hint: ", output)
    else:
        output = "No, the number is a lower than that"
        mb.showinfo("Hint: ", output)

print("Done")
