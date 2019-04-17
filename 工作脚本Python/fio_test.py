#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import os

for rw in ("read","write","ranread","ranwrite"):

    for numjobs in ("4","8","16"):
        command = "fio -name=******* --bs=1M" + \
                  " --ioengine=windowsaio --iodepth=128 --size=10M" + \
                  " --direct=1 --rw=" + str(rw) + " --filename=C:" + \
                  " --numjobs=" + str(numjobs) + " --time_based" + \
                  " --runtime=30 --group_reporting -thread"
        res = os.popen(command)
        print (str(res.read()))

        '''
        f = open(rw +"_"+numjobs+"_out.txt","w")
        f.write(str(res.read()))
        f.close() '''