#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import  requests

def loginData():
   data = {
      'email': '13484545195',
      'icode': '',
      'origURL': 'http://www.renren.com/home',
      'domain': 'renren.com',
      'key_id': 1,
      'captcha_type': 'web_login',
      'password': '8d9a71152919613bbe3df9bfa0e1b390eb2b13dd1bdde270c2816cf04dd1b7c5',
      'rkey': 'b4cdc6acc1d36171e3de73dd4676208e',
      'f': 'http%3A%2F%2Fname.renren.com%2F'}
   return data


def login():
   r = requests.post(
      url='http://www.renren.com/ajaxLogin/login?1=1&uniqueTimestamp=201894216799',
      data=loginData(),
      headers={'Content-Type': 'application/x-www-form-urlencoded'})
   return r.cookies


def uploadData():
   data = {
      "upload": "提交",
      "__channel": "renren",
      "privacyParams": '{"sourceControl": 99}',
      'hostid': '967004081',
      'requestToken': '-1124080368',
      '_rtk': '88c0e36a'}
   return data


def upload():
   r = requests.post(
      url='http://upload.renren.com/upload.fcgi?pagetype=addpublishersingle&hostid=967004081&'
          'callback=window.parent.handlePhotoData&uploadid=profile_publisher_photo_1540215890321',
      data=uploadData(),
      headers={'Conteny-Type': 'multipart/form-data'},
      files={"file": ("wx.jpg", open("c:/wx.jpg", "rb"), "image/jpeg", {})},
      cookies=login())
   print(r.status_code)
   print(r.text)


if __name__ == '__main__':
   upload()