#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pika
import sys

credentials = pika.PlainCredentials('openstack', 'openstack')
connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.56.11',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare('logs',
                         'fanout')

#message = ' '.join(sys.argv[1:]) or "info: Hello World!"
message = "info: Hello World!"
channel.basic_publish(exchange='logs',
                      routing_key='',
                      body=message)
print(" [x] Sent %r" % message)
connection.close()