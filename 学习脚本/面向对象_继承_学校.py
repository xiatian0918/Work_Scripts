#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

class SchoolMember(object):
    def __init__(self,name,addr):
        self.name = name
        self.addr = addr
        self.students = []
        self.teachers = []

    def enroll(self,stu_obj):
        print("为学院 %s 办理注册手续" %stu_obj.name)
        self.students.append(stu_obj)


class SchoolMember(object):
    def __init__(self,name,age,sex,):
        self.name = name
        self.age = age
        self.sex = sex

    def tell(self):
        pass

class Teacher(SchoolMember):
    def __init__(self,name,age,sex,salary,course):
        super(Teacher.self).__init__(name,age,sex)
        self.salary = salary
        self.course = course

    def tell(self):
        print('''
        --- info of Teacher:%s ---
        Name:%s
        Age:%s
        Sex:%s
        Salary:%s
        Cource:%s
        '''%(self.name,self.name,self.age,self.sex,self.salary,self.course)
        )

        def teach(self):
            print("%s is teaching cource [%s]" %(self.name,self.course))


