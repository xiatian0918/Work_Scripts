运维自动化脚本
        
说明：其中包括Shell语言脚本和Python语言脚本，还有学习测试的一些脚本。
    
    
 依赖系统：
 
    	
    	[root@monitor-centreon ~]# cat /etc/redhat-release 
    	CentOS Linux release 7.4.1708 (Core) 
    	
        
	[root@toprs-jumper gitlab]# tree -N -d
		.
		├── 工作脚本Python
		├── 工作脚本Shell
		└── 学习脚本

		3 directories
	
	[root@toprs-jumper gitlab]# tree -N -f
		.
		├── ./README.md
		├── ./工作脚本Python
		│   ├── ./工作脚本Python/api上传图片.py
		│   ├── ./工作脚本Python/clone_vm.py
		│   ├── ./工作脚本Python/fio_test.py
		│   ├── ./工作脚本Python/get_dhcp.py
		│   ├── ./工作脚本Python/get_ip_mac.py
		│   ├── ./工作脚本Python/get_ip.py
		│   ├── ./工作脚本Python/get_systeminfo.py
		│   ├── ./工作脚本Python/get_windows_disk.py
		│   ├── ./工作脚本Python/input_passwd.py
		│   ├── ./工作脚本Python/mongodb关系.py
		│   ├── ./工作脚本Python/monitor_rabbitmq.py
		│   ├── ./工作脚本Python/ping.py
		│   ├── ./工作脚本Python/price.py
		│   ├── ./工作脚本Python/python.py
		│   ├── ./工作脚本Python/python_redis.py
		│   ├── ./工作脚本Python/python_time.py
		│   ├── ./工作脚本Python/python修改IP.py
		│   ├── ./工作脚本Python/python修改windows IP地址.py
		│   ├── ./工作脚本Python/session.py
		│   ├── ./工作脚本Python/share_dir.py
		│   ├── ./工作脚本Python/test_ping.py
		│   ├── ./工作脚本Python/vcenter_api.py
		│   ├── ./工作脚本Python/vm_hard_info.py
		│   ├── ./工作脚本Python/vmware_host_cpu.py
		│   ├── ./工作脚本Python/vmware_host_memory.py
		│   ├── ./工作脚本Python/vmware_host_power.py
		│   ├── ./工作脚本Python/绑定hosts文件.py
		│   ├── ./工作脚本Python/备份数据.py
		│   ├── ./工作脚本Python/测试创建虚拟机.py
		│   ├── ./工作脚本Python/测试模块.py
		│   ├── ./工作脚本Python/测试域名.py
		│   ├── ./工作脚本Python/测试云平台所有域名.py
		│   ├── ./工作脚本Python/查看MongoDB复制集状态.py
		│   ├── ./工作脚本Python/查看vm列表.py
		│   ├── ./工作脚本Python/查看当前正在使用的IP.py
		│   ├── ./工作脚本Python/查看端口被占用及通过pid杀掉进程.py
		│   ├── ./工作脚本Python/传参测试域名.py
		│   ├── ./工作脚本Python/代码回滚脚本.py
		│   ├── ./工作脚本Python/代码上线发布.py
		│   ├── ./工作脚本Python/调用ansible命令脚本.py
		│   ├── ./工作脚本Python/读取记事本信息.py
		│   ├── ./工作脚本Python/更改CPU.py
		│   ├── ./工作脚本Python/更改内存.py
		│   ├── ./工作脚本Python/更改字样脚本.py
		│   ├── ./工作脚本Python/更新windows系统时间.py
		│   ├── ./工作脚本Python/获取IP_MAC_HOSTNAME.py
		│   ├── ./工作脚本Python/获取mongodb信息.py
		│   ├── ./工作脚本Python/获取mongodb主从关系脚本.py
		│   ├── ./工作脚本Python/获取VDS信息.py
		│   ├── ./工作脚本Python/获取vmware虚拟主机详细信息.py
		│   ├── ./工作脚本Python/获取VSS信息.py
		│   ├── ./工作脚本Python/获取主机IP、MAC、hostname.py
		│   ├── ./工作脚本Python/检查mongodb主从端口.py
		│   ├── ./工作脚本Python/克隆虚拟机.py
		│   ├── ./工作脚本Python/配置windows系统时间.py
		│   ├── ./工作脚本Python/请求API示例.py
		│   ├── ./工作脚本Python/删除虚拟机.py
		│   ├── ./工作脚本Python/上传文件到共享存储.py
		│   ├── ./工作脚本Python/生成excel.py
		│   ├── ./工作脚本Python/修改内存资源.py
		│   ├── ./工作脚本Python/域名.py
		│   ├── ./工作脚本Python/远程执行windows.py
		│   ├── ./工作脚本Python/运行测试.py
		│   └── ./工作脚本Python/自动化上传匀光匀色模板.py
		├── ./工作脚本Shell
		│   ├── ./工作脚本Shell/add_uesr.sh
		│   ├── ./工作脚本Shell/add_user_key_ssh.sh
		│   ├── ./工作脚本Shell/ansible_get_nfs.sh
		│   ├── ./工作脚本Shell/auto_deploy.sh
		│   ├── ./工作脚本Shell/bak_file.sh
		│   ├── ./工作脚本Shell/bak_git_data.sh
		│   ├── ./工作脚本Shell/bak_mysql.sh
		│   ├── ./工作脚本Shell/check_desktop_users
		│   ├── ./工作脚本Shell/check_disk_io.sh
		│   ├── ./工作脚本Shell/check_es_status.sh
		│   ├── ./工作脚本Shell/check_mongo_rep.sh
		│   ├── ./工作脚本Shell/check_mysql_slave.sh
		│   ├── ./工作脚本Shell/check_nginx.sh
		│   ├── ./工作脚本Shell/check.sh
		│   ├── ./工作脚本Shell/check_total.sh
		│   ├── ./工作脚本Shell/check_uwsgi.sh
		│   ├── ./工作脚本Shell/code_back.sh
		│   ├── ./工作脚本Shell/code_online.sh
		│   ├── ./工作脚本Shell/code_show.sh
		│   ├── ./工作脚本Shell/collect_ceph_log.sh
		│   ├── ./工作脚本Shell/ConfigureRemotingForAnsible.ps1
		│   ├── ./工作脚本Shell/copy_file.py
		│   ├── ./工作脚本Shell/cpu.py
		│   ├── ./工作脚本Shell/cut_nginx_log.sh
		│   ├── ./工作脚本Shell/del_file_symbol.sh
		│   ├── ./工作脚本Shell/del_share_storage.sh
		│   ├── ./工作脚本Shell/double_copy_file.py
		│   ├── ./工作脚本Shell/es_del_index_bakup.py
		│   ├── ./工作脚本Shell/es_del_index.py
		│   ├── ./工作脚本Shell/exprt_file.py
		│   ├── ./工作脚本Shell/fio_test.sh
		│   ├── ./工作脚本Shell/get_black_ip.sh
		│   ├── ./工作脚本Shell/get_dhcp.sh
		│   ├── ./工作脚本Shell/get_diqu.sh
		│   ├── ./工作脚本Shell/get_hostname_ip.sh
		│   ├── ./工作脚本Shell/get_redis.sh
		│   ├── ./工作脚本Shell/get_windows_filename.sh
		│   ├── ./工作脚本Shell/install_ansible.sh
		│   ├── ./工作脚本Shell/install_fio.sh
		│   ├── ./工作脚本Shell/install_git-2.7.4.sh
		│   ├── ./工作脚本Shell/install_GlusterFS.sh
		│   ├── ./工作脚本Shell/install_init_new.sh
		│   ├── ./工作脚本Shell/install_iperf.sh
		│   ├── ./工作脚本Shell/install_jdk_1.8.152.sh
		│   ├── ./工作脚本Shell/install_keepalived.sh
		│   ├── ./工作脚本Shell/install_mariadb.sh
		│   ├── ./工作脚本Shell/install_nginx.sh
		│   ├── ./工作脚本Shell/install_nginx+uwsgi+django+python.sh
		│   ├── ./工作脚本Shell/install_postfix_dovecot.sh
		│   ├── ./工作脚本Shell/install_rabitmq.sh
		│   ├── ./工作脚本Shell/install_redis_3.2.6.sh
		│   ├── ./工作脚本Shell/install_redmine-3.4.6.sh
		│   ├── ./工作脚本Shell/ip_total_map.sh
		│   ├── ./工作脚本Shell/local_fio.sh
		│   ├── ./工作脚本Shell/modify_secret.sh
		│   ├── ./工作脚本Shell/move_code_bak.sh
		│   ├── ./工作脚本Shell/new_fio_test.sh
		│   ├── ./工作脚本Shell/pyfio.py
		│   ├── ./工作脚本Shell/res_django_service.sh
		│   ├── ./工作脚本Shell/sersync.sh
		│   ├── ./工作脚本Shell/set_time.py
		│   ├── ./工作脚本Shell/single_copy_file.py
		│   ├── ./工作脚本Shell/ssrmu.sh
		│   ├── ./工作脚本Shell/test.py
		│   ├── ./工作脚本Shell/ubuntu_manage_source.sh
		│   ├── ./工作脚本Shell/update_centos_time.sh
		│   ├── ./工作脚本Shell/update_time.sh
		│   ├── ./工作脚本Shell/保密结果检查.sh
		│   ├── ./工作脚本Shell/更改字样脚本.py
		│   ├── ./工作脚本Shell/获取Vcenter网络信息.sh
		│   ├── ./工作脚本Shell/获取单个网络接口流量示例.sh
		│   ├── ./工作脚本Shell/获取虚拟化宿主机接口名称.sh
		│   ├── ./工作脚本Shell/获取虚拟化宿主机信息.sh
		│   ├── ./工作脚本Shell/获取虚拟机网卡网络详细信息.sh
		│   ├── ./工作脚本Shell/获取虚拟机网卡信息.sh
		│   ├── ./工作脚本Shell/获取虚拟主机详细信息.sh
		│   ├── ./工作脚本Shell/监控虚拟机Vmotion状态.sh
		│   ├── ./工作脚本Shell/通过虚拟机IP地址获取网卡MAC地址.sh
		│   ├── ./工作脚本Shell/修改虚拟化计算节点名称.sh
		│   ├── ./工作脚本Shell/自动化更改虚拟机CPU.sh
		│   ├── ./工作脚本Shell/自动化更改虚拟机电源.sh
		│   ├── ./工作脚本Shell/自动化更改虚拟机内存.sh
		│   ├── ./工作脚本Shell/自动化克隆虚拟机.sh
		│   ├── ./工作脚本Shell/自动化删除虚拟机.sh
		│   ├── ./工作脚本Shell/自动化上传匀光匀色模板.sh
		│   └── ./工作脚本Shell/自动检查ceph集群节点messages日志错误.sh
		└── ./学习脚本
			├── ./学习脚本/excel.py
			├── ./学习脚本/for.py
			├── ./学习脚本/func_test.py
			├── ./学习脚本/json反序列化.py
			├── ./学习脚本/json序列化.py
			├── ./学习脚本/main.py
			├── ./学习脚本/module_test.py
			├── ./学习脚本/pipe2.py
			├── ./学习脚本/select_socket_server.py
			├── ./学习脚本/shopping.py
			├── ./学习脚本/shutil模块.py
			├── ./学习脚本/socket_client.py
			├── ./学习脚本/socket_server.py
			├── ./学习脚本/sock_server_client.py
			├── ./学习脚本/sock_server_ssh.py
			├── ./学习脚本/test2.py
			├── ./学习脚本/test_clone.py
			├── ./学习脚本/test.py
			├── ./学习脚本/threading_ex1.py
			├── ./学习脚本/threading_ex2.py
			├── ./学习脚本/常用模块.py
			├── ./学习脚本/传参测试域名.py
			├── ./学习脚本/队列.py
			├── ./学习脚本/多进程.py
			├── ./学习脚本/反射.py
			├── ./学习脚本/函数.py
			├── ./学习脚本/获取linux系统IP.py
			├── ./学习脚本/获取进程ID.py
			├── ./学习脚本/进程queue.py
			├── ./学习脚本/进程池.py
			├── ./学习脚本/静态方法.py
			├── ./学习脚本/面向对象_狗.py
			├── ./学习脚本/面向对象_继承.py
			├── ./学习脚本/面向对象_继承_学校.py
			├── ./学习脚本/内置方法.py
			├── ./学习脚本/内置函数.py
			├── ./学习脚本/爬虫脚本.py
			├── ./学习脚本/切分.py
			├── ./学习脚本/生产者消费者.py
			├── ./学习脚本/生成器.py
			├── ./学习脚本/实现验证码功能.py
			├── ./学习脚本/时间模块.py
			├── ./学习脚本/属性方法.py
			├── ./学习脚本/显示json格式.py
			├── ./学习脚本/线程.py
			├── ./学习脚本/协程.py
			├── ./学习脚本/异常处理.py
			└── ./学习脚本/自动协程.py

		3 directories, 199 files
   
    
	=====================
    
    	Python脚本执行方式
    	
    	Python版本
    
            [root@monitor-centreon scripts]# python -V
            Python 2.7.5
    
            root@toprs-virtual-host:~# python -V
            Python 3.6.7
    
            [root@monitor-centreon scripts]# python vm_hard_info.py
