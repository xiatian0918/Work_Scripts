# /usr/bin/env python
# -*- coding:utf-8 -*-


from smb.SMBConnection import SMBConnection
from config import *

class ConnectSamba():

'''
    def __init__(self):
        self.user_name = 'admin'
        self.pass_word = 'password'
        self.my_name = SAMBA_MYNAME
        self.domain_name = SAMBA_DOMAINNAME
        self.remote_smb_IP = SAMBA_REMOTEIP
        self.port = SAMBA_PORT
        self.dir = SAMBA_DIR
'''

    def downloadFile(self, filename, download_filepath):
        '''
        下载文件
        :param filename: 保存到本地的文件名
        :param download_filepath: 保存到本地文件的路径
        :return:c
        '''
        try:
            conn = SMBConnection(self.user_name, self.pass_word, self.my_name, self.domain_name, use_ntlm_v2=True)
            conn.connect(self.remote_smb_IP, self.port)
            file_obj = open(download_filepath + filename, 'wb')
            conn.retrieveFile(self.dir, filename, file_obj)
            file_obj.close()
            return True
        except:
            return False

    def uploadFile(self, filename, upload_path):
        '''
        上传文件
        :param filename: 上传文件的名称
        :param upload_path: 上传文件的路径
        :return:True or False
        '''
        try:
            conn = SMBConnection(self.user_name, self.pass_word, self.my_name, self.domain_name, use_ntlm_v2=True)
            conn.connect(self.remote_smb_IP, self.port)
            file_obj = open(upload_path + filename, 'rb')
            conn.storeFile(self.dir, filename, file_obj)
            file_obj.close()
            return True
        except:
            return False


c = ConnectSamba()
c.downloadFile('ceshi.txt', 'F:\\samba\\')
c.uploadFile('ceshi.txt', 'F:\\samba\\')