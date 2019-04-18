#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

"""
只用于模拟开发功能测试
"""
from pyVmomi import vim
#from pyVim.connect import SmartConnect, Disconnect, SmartConnectNoSSL
import atexit
import argparse


def get_args():
    parser = argparse.ArgumentParser(
        description='Arguments for talking to vCenter')

    parser.add_argument('-s', '--host',
                        required=True,
                        action='store',
                        help='vSpehre service to connect to')

    parser.add_argument('-o', '--port',
                        type=int,
                        default=443,
                        action='store',
                        help='Port to connect on')

    parser.add_argument('-u', '--user',
                        required=True,
                        action='store',
                        help='User name to use')

    parser.add_argument('-p', '--password',
                        required=True,
                        action='store',
                        help='Password to use')

    args = parser.parse_args()
    return args


def get_obj(content, vimtype, name=None):
    '''
    列表返回,name 可以指定匹配的对象
    '''
    container = content.viewManager.CreateContainerView(content.rootFolder, vimtype, True)
    obj = [ view for view in container.view]
    return obj


def main():
    esxi_host = {}
    args = get_args()
    # connect this thing
    si = SmartConnectNoSSL(
            host=args.host,
            user=args.user,
            pwd=args.password,
            port=args.port)
    # disconnect this thing
    atexit.register(Disconnect, si)
    content = si.RetrieveContent()
    esxi_obj = get_obj(content, [vim.HostSystem])
    for esxi in esxi_obj:
        esxi_host[esxi.name] = {'esxi_info':{},'datastore':{}, 'network': {}, 'vm': {}}

        esxi_host[esxi.name]['esxi_info']['厂商'] = esxi.summary.hardware.vendor
        esxi_host[esxi.name]['esxi_info']['型号'] = esxi.summary.hardware.model
        for i in esxi.summary.hardware.otherIdentifyingInfo:
            if isinstance(i, vim.host.SystemIdentificationInfo):
                esxi_host[esxi.name]['esxi_info']['SN'] = i.identifierValue
        esxi_host[esxi.name]['esxi_info']['处理器'] = '数量：%s 核数：%s 线程数：%s 频率：%s(%s) ' % (esxi.summary.hardware.numCpuPkgs,
                                                                                      esxi.summary.hardware.numCpuCores,
                                                                                      esxi.summary.hardware.numCpuThreads,
                                                                                      esxi.summary.hardware.cpuMhz,
                                                                                      esxi.summary.hardware.cpuModel)
        esxi_host[esxi.name]['esxi_info']['处理器使用率'] = '%.1f%%' % (esxi.summary.quickStats.overallCpuUsage /
                                                       (esxi.summary.hardware.numCpuPkgs * esxi.summary.hardware.numCpuCores * esxi.summary.hardware.cpuMhz) * 100)
        esxi_host[esxi.name]['esxi_info']['内存(MB)'] = esxi.summary.hardware.memorySize/1024/1024
        esxi_host[esxi.name]['esxi_info']['可用内存(MB)'] = '%.1f MB' % ((esxi.summary.hardware.memorySize/1024/1024) - esxi.summary.quickStats.overallMemoryUsage)
        esxi_host[esxi.name]['esxi_info']['内存使用率'] = '%.1f%%' % ((esxi.summary.quickStats.overallMemoryUsage / (esxi.summary.hardware.memorySize/1024/1024)) * 100)
        esxi_host[esxi.name]['esxi_info']['系统'] = esxi.summary.config.product.fullName

        for ds in esxi.datastore:
            esxi_host[esxi.name]['datastore'][ds.name] = {}
            esxi_host[esxi.name]['datastore'][ds.name]['总容量(G)'] = int((ds.summary.capacity)/1024/1024/1024)
            esxi_host[esxi.name]['datastore'][ds.name]['空闲容量(G)'] = int((ds.summary.freeSpace)/1024/1024/1024)
            esxi_host[esxi.name]['datastore'][ds.name]['类型'] = (ds.summary.type)
        for nt in esxi.network:
            esxi_host[esxi.name]['network'][nt.name] = {}
            esxi_host[esxi.name]['network'][nt.name]['标签ID'] = nt.name
        for vm in esxi.vm:
            esxi_host[esxi.name]['vm'][vm.name] = {}
            esxi_host[esxi.name]['vm'][vm.name]['电源状态'] = vm.runtime.powerState
            esxi_host[esxi.name]['vm'][vm.name]['CPU(内核总数)'] = vm.config.hardware.numCPU
            esxi_host[esxi.name]['vm'][vm.name]['内存(总数MB)'] = vm.config.hardware.memoryMB
            esxi_host[esxi.name]['vm'][vm.name]['系统信息'] = vm.config.guestFullName
            if vm.guest.ipAddress:
                esxi_host[esxi.name]['vm'][vm.name]['IP'] = vm.guest.ipAddress
            else:
                esxi_host[esxi.name]['vm'][vm.name]['IP'] = '服务器需要开机后才可以获取'

            for d in vm.config.hardware.device:
                if isinstance(d, vim.vm.device.VirtualDisk):
                    esxi_host[esxi.name]['vm'][vm.name][d.deviceInfo.label] = str((d.capacityInKB)/1024/1024) + ' GB'

    f = open(args.host + '.txt', 'w')
    for host in esxi_host:
        print('ESXI IP:', host)
        f.write('ESXI IP: %s \n' % host)
        for hd in esxi_host[host]['esxi_info']:
            print('  %s:    %s' % (hd, esxi_host[host]['esxi_info'][hd]))
            f.write('  %s:    %s' % (hd, esxi_host[host]['esxi_info'][hd]))
        for ds in esxi_host[host]['datastore']:
            print('  存储名称：', ds)
            f.write('  存储名称： %s \n' % ds)
            for k in esxi_host[host]['datastore'][ds]:
                print('       %s:  %s' % (k, esxi_host[host]['datastore'][ds][k]))
                f.write('       %s:  %s \n' % (k, esxi_host[host]['datastore'][ds][k]))
        for nt in esxi_host[host]['network']:
            print('  网络名称：', nt)
            f.write('  网络名称：%s \n' % nt)
            for k in esxi_host[host]['network'][nt]:
                print('        %s:  %s' % (k, esxi_host[host]['network'][nt][k]))
                f.write('        %s:  %s \n' % (k, esxi_host[host]['network'][nt][k]))
        for vmachine in esxi_host[host]['vm']:
            print('  虚拟机名称：', vmachine)
            f.write('  虚拟机名称：%s \n' % vmachine)
            for k in esxi_host[host]['vm'][vmachine]:
                print('        %s:  %s' % (k, esxi_host[host]['vm'][vmachine][k]))
                f.write('        %s:  %s \n' % (k, esxi_host[host]['vm'][vmachine][k]))
    f.close()


if __name__ == '__main__':
    main()