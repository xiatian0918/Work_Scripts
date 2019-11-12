### VMware vSphere API 

------

###### 1.获取token

```
[root@toprs-jumper ~]# php /root/session.php 
5b38b757bdc39da78aeb93f0cf0eeb19

[root@toprs-jumper ~]# python /data/scripts/session.py 
fc35c5709115578958f94e35dcf291d6

```

###### 2.查看EXSI主机状态信息

```
[root@toprs-jumper vmware_api]# sh check_exsi_info.sh 
{
  "value": [
    {
      "power_state": "POWERED_ON",
      "connection_state": "CONNECTED",
      "name": "192.168.0.21",
      "host": "host-152"
    },
    {
      "power_state": "POWERED_ON",
      "connection_state": "CONNECTED",
      "name": "192.168.0.22",
      "host": "host-174"
    },
    {
      "power_state": "POWERED_ON",
      "connection_state": "CONNECTED",
      "name": "192.168.0.23",
      "host": "host-196"
    }
  ]
}
```

###### 3.查看EXSI块存储容量

```
[root@toprs-jumper vmware_api]# sh check_vmware_disk.sh 
磁盘lun_01  1092.42M
磁盘lun_02  1078.78M
磁盘lun_03  1527.63M
```

###### 4.重启虚拟机电源

```
[root@toprs-jumper vmware_api]# sh /home/xiatian/vmware_api/reset_host_power.sh ceshi-f4

[root@toprs-images-proxy ~]# sh /data/scripts/重启虚拟机.sh ceshi-f4
Found: ceshi-f4
The current powerState is: poweredOn
its done.
```

###### 5.更改CPU资源

```
[root@toprs-jumper vmware_api]# sh /home/xiatian/vmware_api/cpu.sh ceshi-f4 9
在当前虚拟化环境中名称为:ceshi名称命名的虚拟机有:
ceshi-watchdog
ceshi-a1
ceshi-f4
ceshi-g0
ceshi-g1
ceshi-g2  
你要修改的虚拟机：ceshi-f4，修改后的CPU资源为：9,已修改成功
```

###### 6.更改内存资源

```
[root@toprs-jumper vmware_api]# sh /home/xiatian/vmware_api/mem.sh ceshi-f4 8200
在当前虚拟化环境中名称为:ceshi名称命名的虚拟机有:
ceshi-watchdog
ceshi-a1
ceshi-f4
ceshi-g0
ceshi-g1
ceshi-g2  
你要修改的虚拟机：ceshi-f4，修改后的内存资源为：8200,已修改成功
```

###### 7.删除虚拟机

```
[root@toprs-jumper vmware_api]# sh /home/xiatian/vmware_api/自动化删除虚拟机.sh ceshi-f4
```

###### 8.创建虚拟机快照

```
[root@toprs-images-proxy ~]# sh /root/create_kuaizhao.sh
```

###### 9.克隆虚拟机

```
[root@monitor-centreon ~]# ls /data/scripts/auto_clone_vm.sh "data_process-192.168.0.81" data-01
```

###### 10.监控新建虚拟机信息

```
[root@monitor-centreon ~]# sh /data/scripts/monitor_data/write_monitor_mysql_copy.sh
```

```
[root@toprs-jumper ~]# mysql -h192.168.0.53 -uroot -p123456789 toprs -e "select * from tb_monitor_vm;"
+--------+----------------+---------+--------+------------+----------+---------+--------------+---------------+
| id     | vm_name        | cpu_use | memory | memory_use | write_io | read_io | bandwidth_in | bandwidth_out |
+--------+----------------+---------+--------+------------+----------+---------+--------------+---------------+
| 214584 | ceshi-a1       | 0.00%   | NULL   | 29%        | 4.28     | 5.52    | 3751.40      | 2250.50       |
| 214585 | ceshi-f4       | 0.22%   | NULL   | 9%         | 4.84     | 12.11   | 8.10         | 3.20          |
| 214586 | ceshi-g0       | 0.25%   | NULL   | 12%        | 3.59     | 25.00   | 1959.74      | 3975.03       |
| 214587 | ceshi-watchdog | 0.00%   | NULL   | 10%        | 1.20     | 5.44    | 134.05       | 1726.41       |
| 214588 | ceshi-g1       | 0.00%   | NULL   | 9%         | 3.26     | 10.59   | 1466.69      | 3545.13       |
| 214589 | ceshi-g2       | 0.00%   | NULL   | 9%         | 3.83     | 5.59    | 2406.43      | 295.94        |
+--------+----------------+---------+--------+------------+----------+---------+--------------+---------------+
```