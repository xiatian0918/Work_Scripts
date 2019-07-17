#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pika,time

credentials = pika.PlainCredentials('toprs', 'toprs')
connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.0.58',5672,'/',credentials))
channel = connection.channel()  #声明一个管道

# 声明queue
channel.queue_declare(queue='hello2')

# n RabbitMQ a message can never be sent directly to the queue, it always needs to go through an exchange.
channel.basic_publish(exchange='',
                      routing_key='hello2',
                      body='Hello World!')

print(" [x] Sent 'Hello World!'")
connection.close()