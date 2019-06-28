#!/usr/bin/env python
#-*- coding:utf-8 -*-

import os
ser_time = os.system("date +'%Y-%m-%d'")
local_time = os.system("date +'%H:%M:%S'")

#os.system(ansible data -m win_shell -a Set-Date ser_time local_time)
#b = os.system("ansible data -m win_shell -a Set-Date"+ser_time+ local_time)
b = os.system("ansible data -m win_shell -a Set-Date"+str(ser_time)+ str(local_time))
print(b)
