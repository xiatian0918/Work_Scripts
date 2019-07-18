运维自动化脚本

        
说明：其中包括Shell语言脚本和Python语言脚本，还有学习测试的一些脚本。
    	
依赖系统：
    	
    [root@monitor-centreon ~]# cat /etc/redhat-release 
    CentOS Linux release 7.4.1708 (Core) 
    
    

    	
Python版本
    
    [root@monitor-centreon scripts]# python -V
    Python 2.7.5
    
    root@toprs-virtual-host:~# python -V
    Python 3.6.7


目录及文件名称
        
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
		│   ├── ./工作脚本Python/代码上线发布.py
		│   ├── ./工作脚本Python/调用ansible命令脚本.py
		│   ├── ./工作脚本Python/读取记事本信息.py
		│   ├── ./工作脚本Python/更改CPU.py
		│   ├── ./工作脚本Python/更改内存.py
		│   ├── ./工作脚本Python/更改字样脚本.py
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
		│   ├── ./工作脚本Shell/check_es_status.sh
		│   ├── ./工作脚本Shell/check_mongo_rep.sh
		│   ├── ./工作脚本Shell/check_mysql_slave.sh
		│   ├── ./工作脚本Shell/check_nginx.sh
		│   ├── ./工作脚本Shell/check.sh
		│   ├── ./工作脚本Shell/cut_nginx_log.sh
		│   ├── ./工作脚本Shell/del_file_symbol.sh
		│   ├── ./工作脚本Shell/fio_test.sh
		│   ├── ./工作脚本Shell/get_black_ip.sh
		│   ├── ./工作脚本Shell/get_dhcp.sh
		│   ├── ./工作脚本Shell/get_diqu.sh
		│   ├── ./工作脚本Shell/get_hostname_ip.sh
		│   ├── ./工作脚本Shell/get_redis.sh
		│   ├── ./工作脚本Shell/get_windows_filename.sh
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
		│   ├── ./工作脚本Shell/保密结果检查.sh
		│   ├── ./工作脚本Shell/更改字样脚本.py
		│   ├── ./工作脚本Shell/获取Vcenter网络信息.sh
		│   ├── ./工作脚本Shell/获取单个网络接口流量示例.sh
		3 directories, 199 files

