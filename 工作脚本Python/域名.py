def main(a):
    list_name = []
    for i in a:
        name = i.split('   ')[1]
        list_name.append(name)
    print('域名为：', list_name)


a = ['192.168.0.66   web.toprs.cloud.com','192.168.0.66   api.toprs.cloud.com', \
          '192.168.0.62   down.toprs.cloud.com','192.168.0.64   monitor.toprs.cloud.com', \
          '192.168.0.55   git.toprs.cloud.com','192.168.0.57   redmine.toprs.cloud.com', \
           '192.168.0.54   log.toprs.cloud.com','192.168.0.65   network.toprs.cloud.com', \
          '192.168.0.60   mail.toprs.cloud.com','192.168.0.67   images.toprs.cloud.com']


if __name__ == '__main__':
     main(a)