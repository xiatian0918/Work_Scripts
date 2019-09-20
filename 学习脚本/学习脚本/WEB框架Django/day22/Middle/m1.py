#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

from django.utils.deprecation import MiddlewareMixin

class Row1(MiddlewareMixin):
    def process_request(self,request):
        print("王森")

    def process_view(self,request,view_func,view_func_args,view_func_kwargs):
        print("张欣彤")

    def process_response(self,response,request):
        print("扛把子")

class Row2(MiddlewareMixin):
    def process_request(self,request):
        print("程义强")

    def process_response(self, response, request):
        pass

class Row3(MiddlewareMixin):
    def process_request(self,request):
        print("刘东")

    def process_response(self, response, request):
        pass

    def process_exception(self,request,exception):
        if isinstance(exception,ValueError):
            print('9999999999999')

    def process_template_response(self,request,response):
        # 如果Views中的函数返回的对象中，具有render方法
        print('--------------------------------')

        pass