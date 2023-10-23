#!/bin/bash
# author: sun977
# use: restart sync_assets.py
# date: 2023-10-23

# 杀掉所有 sync_assets.py进程
pid=`ps -aux | grep sync_assets.py | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        kill -9 $pid
        echo "python3 sync_assets.py pid $pid killd"
fi

# 重启扫描进程【进程会听在这里无法退出--加个&可以解决这个问题】
setsid nohup python3 /opt/python/GodV_Intranet_docker/sync_assets.py >> /opt/python/GodV_Intranet_docker/nohup.out 2>&1 &
#setsid nohup python3 /opt/python/GodV_Intranet/sync_assets.py >> /opt/python/GodV_Intranet_docker/nohup.out 2>&1 &
if [ $? -eq 0 ] ; then
        echo "sync_assets.py restart success"
fi
