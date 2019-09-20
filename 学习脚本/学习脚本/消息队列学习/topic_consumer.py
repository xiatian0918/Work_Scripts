#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pika
import sys

credentials = pika.PlainCredentials('openstack', 'openstack')
connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.56.11',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare('topic_logs',
                         'topic')

result = channel.queue_declare('topic_logs',
                                'topic')
queue_name = result.method.queue

binding_keys = sys.argv[1:]
if not binding_keys:
    sys.stderr.write("Usage: %s [binding_key]...\n" % sys.argv[0])
    sys.exit(1)

for binding_key in binding_keys:
    channel.queue_bind(exchange='topic_logs',
                       queue=queue_name,
                       routing_key=binding_key)

print(' [*] Waiting for logs. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))


channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()