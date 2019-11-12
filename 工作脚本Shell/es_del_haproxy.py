#!/usr/bin/env python

import os
import datetime

ti = ((datetime.datetime.now()-datetime.timedelta(days=8)).strftime("%Y.%m.%d"))

os.system("curl -XDELETE http://192.168.0.67:9200/tgc-haproxy-access-%s"%(ti))
