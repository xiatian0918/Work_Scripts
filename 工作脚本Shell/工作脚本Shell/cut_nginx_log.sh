#!/bin/bash
 
LogPath=/data/log/nginx
#BackupPath=/data/BackupLogs/
Yesterday=`date -d "yesterday" +%Y%m%d`
BackupPath=/data/BackupLogs/${Yesterday}
#NginxPid=`cat /var/run/nginx.pid`
NginxPid=`cat /usr/local/nginx/logs/nginx.pid`
BackupSaveCycle=+5
[ -d ${BackupPath} ] || mkdir -p ${BackupPath}
 
cd $LogPath
mv toprs_access.log $BackupPath\/toprs_access_$Yesterday.log
 
kill -USR1 $NginxPid
sleep 5
cd $BackupPath
gzip toprs_access_$Yesterday.log
sleep 5
find $BackupPath -mtime $BackupSaveCycle -exec rm {} \;

