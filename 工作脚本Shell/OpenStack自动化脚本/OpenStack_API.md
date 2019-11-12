## OpenStack API

###### 1.创建虚拟机

```
[root@openstack-controller ~]# sh /data/scripts/自动化创建虚拟机.sh 1 1048 toprs-007
+----------------------------+--------------------------------------+
| Field                      | Value                                |
+----------------------------+--------------------------------------+
| OS-FLV-DISABLED:disabled   | False                                |
| OS-FLV-EXT-DATA:ephemeral  | 0                                    |
| disk                       | 10                                   |
| id                         | b2e325d5-1ee6-4bc5-8d8f-ecdc10e09821 |
| name                       | toprs-mu                             |
| os-flavor-access:is_public | True                                 |
| properties                 |                                      |
| ram                        | 1048                                 |
| rxtx_factor                | 1.0                                  |
| swap                       |                                      |
| vcpus                      | 1                                    |
+----------------------------+--------------------------------------+

------

虚拟机正在创建过程中,请耐心等待
 恭喜,虚拟机(toprs-007)创建成功! 
```

###### 2.重启虚拟机电源

```
[root@openstack-controller ~]# sh /data/scripts/重启虚拟机.sh toprs-007
```

###### 3.删除虚拟机

```
[root@openstack-controller ~]# sh /data/scripts/删除虚拟机.sh toprs-007
```

###### 4.修改虚拟机资源(内存、CPU)

```
[root@openstack-controller ~]# nova show toprs-002|egrep "flavor:vcpus|flavor:ram|flavor:disk"
| flavor:disk                          | 15                                                       |
| flavor:ram                           | 4000                                                     |
| flavor:vcpus                         | 3                                                        |
[root@openstack-controller ~]# sh /data/scripts/修改虚拟机资源.sh toprs-002 1 1024 15
+----------------------------+--------------------------------------+
| Field                      | Value                                |
+----------------------------+--------------------------------------+
| OS-FLV-DISABLED:disabled   | False                                |
| OS-FLV-EXT-DATA:ephemeral  | 0                                    |
| disk                       | 15                                   |
| id                         | 02d4aff1-c86e-474c-b998-f19fbc99154c |
| name                       | toprs-002_flavor                     |
| os-flavor-access:is_public | True                                 |
| properties                 |                                      |
| ram                        | 1024                                 |
| rxtx_factor                | 1.0                                  |
| swap                       |                                      |
| vcpus                      | 1                                    |
+----------------------------+--------------------------------------+
资源修改成功
[root@openstack-controller ~]# nova show toprs-002|egrep "flavor:vcpus|flavor:ram|flavor:disk"
| flavor:disk                          | 15                                                       |
| flavor:ram                           | 1024                                                     |
| flavor:vcpus                         | 1                                                        |
```

