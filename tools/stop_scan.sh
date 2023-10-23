#!/bin/bash
# author: sun977
# use: stop scan_start.py
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

