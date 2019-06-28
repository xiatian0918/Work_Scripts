#!/usr/bin/env python
# -*- coding:utf-8 -*-


os.system("curl -ksX PATCH --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'vmware-api-session-id: 8c92b049267f669082c8db5a03419e1c' -d '{ \"spec\": { \"hot_add_enabled\": true, \"size_MiB\": 8092 } }' 'https://192.168.0.24/rest/vcenter/vm/vm-76/hardware/memory'")
