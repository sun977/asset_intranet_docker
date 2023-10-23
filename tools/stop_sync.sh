#!/bin/bash
# author: sun977
# use: stop sync_assets.py
# date: 2023-10-23

# 杀掉所有 sync_assets.py进程
pid=`ps -aux | grep sync_assets.py | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        kill -9 $pid
        echo "python3 sync_assets.py pid $pid killd"
fi


