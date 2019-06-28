#!/bin/sh
# time:2019-05-07
# author:HotXia
# this is about how go to bakup gitlab project data is scripts


# 拉取最新系统运维自动化脚本
cd /mnt/system/gitlab_project_bakup/git_bakup/auto_scripts/ && git pull git@192.168.0.55:root/auto_scripts.git master

# 拉取最新后端开发代码
cd /mnt/system/gitlab_project_bakup/git_bakup/develop/ && git pull git@192.168.0.55:root/develop.git master

# 拉取最新前端开发代码
cd /mnt/system/gitlab_project_bakup/git_bakup/liufazhan && git pull git@192.168.0.55:root/liufazhan.git master

# 拉取最新遥感计算处理代码
cd /mnt/system/gitlab_project_bakup/git_bakup/tgc && git pull git@192.168.0.55:root/tgc.git master
