#!/usr/bin/env python

import os
import datetime

ti = ((datetime.datetime.now()-datetime.timedelta(days=8)).strftime("%Y.%m.%d"))

os.system("curl -XDELETE http://192.168.0.54:9200/toprs-web-access-log-%s"%(ti))
