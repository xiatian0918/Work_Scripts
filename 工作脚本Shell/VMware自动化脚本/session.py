#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import requests

requests.packages.urllib3.disable_warnings()

sess = requests.post("https://192.168.0.24/rest/com/vmware/cis/session",  \
                     auth=('administrator@vsphere.local', 'Toprs!@#123'), verify=False)

session_id = sess.json()['value']

print(session_id)
