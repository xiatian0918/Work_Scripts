运维自动化脚本

        说明：其中包括Shell语言脚本和Python语言脚本，还有学习测试的一些脚本。
		
		依赖系统：
		
	    	[root@monitor-centreon ~]# cat /etc/redhat-release 
		    CentOS Linux release 7.4.1708 (Core) 
		
		Shell脚本执行方式：
		
		[root@monitor-centreon scripts]# bash 查看虚拟机硬件设备信息.sh
    		请输入查看的虚拟机IP地址为: 192.168.0.64
    		Found Virtual Machine
    		=====================
    		  guest OS name            : CentOS 7 (64 位)
    		  name                     : toprs-centreon-192.168.0.64
    		  last booted timestamp    : 2019-06-18 00:41:01.197237+00:00
    		  bios UUID                : 422f4466-8ff2-3d6c-cf9c-16b3f3233759
    		  path to VM               : [lun_01] toprs-centreon-192.168.0.64/toprs-centreon-192.168.0.64.vmx
    		  guest OS id              : centos7_64Guest
    		  host name                : 192.168.0.21
    		  instance UUID            : 502f23e5-aa8c-ceaa-584a-eccaf9512c12
    		  Devices:
    		  --------
    		  label: IDE 0
    		  ------------------
    			device type    : vim.vm.device.VirtualIDEController
    			backing type   : NoneType
    			key            : 200
    			summary        : IDE 0
    		  label: IDE 1
    		  ------------------
    			device type    : vim.vm.device.VirtualIDEController
    			backing type   : NoneType
    			key            : 201
    			summary        : IDE 1
    		  label: PS2 控制器 0
    		  ------------------
    			device type    : vim.vm.device.VirtualPS2Controller
    			backing type   : NoneType
    			key            : 300
    			summary        : PS2 控制器 0
    		  label: PCI 控制器 0
    		  ------------------
    			device type    : vim.vm.device.VirtualPCIController
    			backing type   : NoneType
    			key            : 100
    			summary        : PCI 控制器 0
    		  label: SIO 控制器 0
    		  ------------------
    			device type    : vim.vm.device.VirtualSIOController
    			backing type   : NoneType
    			key            : 400
    			summary        : SIO 控制器 0
    		  label: 键盘 
    		  ------------------
    			device type    : vim.vm.device.VirtualKeyboard
    			backing type   : NoneType
    			key            : 600
    			summary        : 键盘
    		  label: 定点设备
    		  ------------------
    			device type    : vim.vm.device.VirtualPointingDevice
    			backing type   : vim.vm.device.VirtualPointingDevice.DeviceBackingInfo
    			key            : 700
    			summary        : 定点设备；设备
    		  ------------------
    		  label: 显卡 
    		  ------------------
    			device type    : vim.vm.device.VirtualVideoCard
    			backing type   : NoneType
    			key            : 500
    			summary        : 显卡
    		  label: VMCI 设备
    		  ------------------
    			device type    : vim.vm.device.VirtualVMCIDevice
    			backing type   : NoneType
    			key            : 12000
    			summary        : 为虚拟机通信接口提供支持的虚拟机 PCI 总线上的设备
    		  label: SCSI 控制器 0
    		  ------------------
    			device type    : vim.vm.device.ParaVirtualSCSIController
    			backing type   : NoneType
    			key            : 1000
    			summary        : VMware 准虚拟 SCSI
    		  label: SATA 控制器 0
    		  ------------------
    			device type    : vim.vm.device.VirtualAHCIController
    			backing type   : NoneType
    			key            : 15000
    			summary        : AHCI
    		  label: CD/DVD 驱动器 1
    		  ------------------
    			device type    : vim.vm.device.VirtualCdrom
    			backing type   : vim.vm.device.VirtualCdrom.RemotePassthroughBackingInfo
    			key            : 16000
    			summary        : 远程设备
    		  ------------------
    		  label: 硬盘 1
    		  ------------------
    			device type    : vim.vm.device.VirtualDisk
    			backing type   : vim.vm.device.VirtualDisk.FlatVer2BackingInfo
    			key            : 2000
    			summary        : 209,715,200 KB
    			datastore
    				name: lun_01
    				host: 192.168.0.21
    				host: 192.168.0.23
    				host: 192.168.0.22
    				summary
    					url: ds:///vmfs/volumes/5bfc1680-8d09db06-5b5e-6c92bf630f88/
    					freeSpace: 992470892544
    					file system: VMFS
    					capacity: 3627905187840
    			fileName: [lun_01] toprs-centreon-192.168.0.64/toprs-centreon-192.168.0.64-000002.vmdk
    			device ID: 
    		  ------------------
    		  label: 软盘驱动器 1
    		  ------------------
    			device type    : vim.vm.device.VirtualFloppy
    			backing type   : vim.vm.device.VirtualFloppy.RemoteDeviceBackingInfo
    			key            : 8000
    			summary        : 远程
    		  ------------------
    		  label: 网络适配器 1
    		  ------------------
    			device type    : vim.vm.device.VirtualVmxnet3
    			backing type   : vim.vm.device.VirtualEthernetCard.NetworkBackingInfo
    			key            : 4000
    			summary        : VM Network
    		  ------------------
    		=====================
		
		Python脚本执行方式
		
		Python版本
		
    		[root@monitor-centreon scripts]# python -V
    		Python 2.7.5
    		
    		root@toprs-virtual-host:~# python -V
    		Python 3.6.7
    		
    		[root@monitor-centreon scripts]# python vm_hard_info.py




