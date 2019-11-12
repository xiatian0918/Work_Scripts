#!/usr/bin/env python
#coding:utf-8
#Author Zhang Jie

import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr
import subprocess
body = ""
false="false"
obj = subprocess.Popen(("curl -sXGET http://192.168.79.154:9200/_cluster/health?pretty=true"),shell=True, stdout=subprocess.PIPE)
data =  obj.stdout.read()
data1 = eval(data)
status = data1.get("status")
if status == "green":
    print ("50")
else:
    print ("100")

