#!/usr/bin/env python
# author: xiatian


#!/usr/bin/env python
# author: xiatian

import winrm,sys
ip_addr = sys.argv[1]


win = winrm.Session('http://%s:5985/wsman' %ip_addr,auth=('administrator','Toprs!@#123'))
r = win.run_cmd('python c:\\get_disk.py')  #执行cmd命令
print(r.std_out.decode().strip()) # 打印获取到的信息
#print(r.std_err) #打印错误信息
