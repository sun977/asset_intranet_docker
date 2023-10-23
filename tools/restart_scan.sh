#!/bin/bash
# author: sun977
# use: restart scan_start.py
# date: 2023-09-23

# 杀掉所有scan_start.py进程
pid=`ps -aux | grep scan_start.py | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        kill -9 $pid
        echo "python3 scan_start.py pid $pid killd"
fi

# 杀掉所有nmap进程
#ps -aux | grep nmap | grep -v grep  | awk '{print $2}' | xargs kill -9
pid=`ps -aux | grep nmap | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        kill -9 $pid
        echo "all nmap pid killd"
fi

# 杀掉所有chromedriver进程
pid=`ps -aux | grep chromedriver | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        kill -9 $pid
        echo "all chromedriver pid killd"
fi

pid=`ps -aux | grep google-chrome | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        kill -9 $pid
        echo "all google-chrome pid killd"
fi

# 重启扫描进程【进程会听在这里无法退出--加个&可以解决这个问题】
setsid nohup python3 /opt/python/GodV_Intranet_docker/scan_start.py >> /opt/python/GodV_Intranet_docker/nohup.out 2>&1 &
if [ $? -eq 0 ] ; then
        echo "scan_start.py restart success"
fi
