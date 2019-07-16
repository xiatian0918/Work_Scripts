#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


import pika

credentials = pika.PlainCredentials('openstack', 'openstack')
connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.56.11',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare('hello2',
                        'logs',
                         'fanout')



result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue
print("------->",queue_name)

channel.queue_bind('logs',
                   queue_name)

print(' [*] Waiting for logs. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] %r" % body)


channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()