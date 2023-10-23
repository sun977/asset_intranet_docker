#!/bin/bash
# wzz
# 停用椒图
/etc/init.d/wsssr_guard stop
/etc/init.d/wsssr stop

# 杀掉所有python进程s
killall python3

# 杀掉所有nmap进程
killall nmap

# 杀掉所有chromedriver进程
killall chromedriver
killall chromium-browse

#重启扫描进程【20230923 add &】
setsid nohup python3 /opt/python/GodV_Intranet/scan_start.py >> /opt/python/GodV_Intranet/nohup.out 2>&1 &

