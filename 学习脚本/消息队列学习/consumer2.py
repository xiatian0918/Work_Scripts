#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatiansd

import pika
# import _md5
# value = _md5.md5('ad'.encode())
# print(value)

credentials = pika.PlainCredentials('openstack', 'openstack')
connection = pika.BlockingConnection(pika.ConnectionParameters(
    '192.168.56.11',5672,'/',credentials))
channel = connection.channel()

# You may ask why we declare the queue again ‒ we have already declared it in our previous code.
# We could avoid that if we were sure that the queue already exists. For example if send.py program
# was run before. But we're not yet sure which program to run first. In such cases it's a good
# practice to repeat declaring the queue in both programs.
channel.queue_declare(queue='hello2')

def callback(ch, method, properties, body):
#    print("--->",ch,method,properties)
    print(" [x] Received %r" % body)

channel.basic_qos(prefetch_count=1)
channel.basic_consume( "hello2",
                      callback, #如果收到消息，就调用callback函数来处理消息
                      True
                      )

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
