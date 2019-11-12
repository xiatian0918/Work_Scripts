#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import psutil
import socket

hostname=socket.gethostname()
ip = socket.gethostbyname(hostname)

disk_io = psutil.disk_io_counters()

print(ip,disk_io)
