#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


from wsgiref.simple_server import make_server

from Controller import account


ULR_DICT = {
    "/index": account.handle_index,
    "/date": account.handle_date,
}

def RunServer(environ, start_response):
    # environ 客户的发来的所有数据
    # start_response 封装要返回给用户的数据，响应头状态
    start_response('200 OK', [('Content-Type', 'text/html')])
    current_url = environ['PATH_INFO']
    func = None
    if current_url in ULR_DICT:
        func = ULR_DICT[current_url]
    if func:
        return func()
    else:
        return ['<h1>404</h1>', encode('utf-8'), ]
    # 返回的内容
 #   return [bytes('<h1>Hello, web!</h1>', encoding='utf-8'), ]


if __name__ == '__main__':
    httpd = make_server('', 8000, RunServer)
    print("Serving HTTP on port 8000...")
    httpd.serve_forever()
