def main(a):
    list_name = []
    for i in a:
        name = i.split('   ')[1]
        list_name.append(name)
    print('域名为：', list_name)


a = ['*******.66   web.*******.*******.com','*******.66   api.*******.*******.com', \
          '*******.62   down.*******.*******.com','*******.64   monitor.*******.*******.com', \
          '*******.55   git.*******.*******.com','*******.57   redmine.*******.*******.com', \
           '*******.54   log.*******.*******.com','*******.65   network.*******.*******.com', \
          '*******.60   mail.*******.*******.com','*******.67   images.*******.*******.com']


if __name__ == '__main__':
     main(a)