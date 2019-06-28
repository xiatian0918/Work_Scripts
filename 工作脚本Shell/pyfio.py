import os

for rw in ("read","write","ranread","ranwrite"):
    for numjobs in ("4","8","16"):
        command = "fio --minimal -name=toprs --bs=1M" + \
                  " --ioengine=windowsaio --iodepth=128 --size=10M" + \
                  " --direct=1 --rw=" + str(rw) + " --filename=C:" + \
                  " --numjobs=" + str(numjobs) + " --time_based" + \
                  " --runtime=30 --group_reporting -thread"
        res = os.popen(command)
        f = open(rw +"_"+numjobs+"_out.txt","w")
        f.write(str(res.read()))
        f.close()