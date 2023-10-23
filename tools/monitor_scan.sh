#!/bin/bash
# author: sun977
# use: monitor scan process
# date: 2023-09-23

# every day 9:00 restart check scan process
# 0 9 * * * /path/to/monitor_scan.sh

current_time=$(date +"%Y-%m-%d %H:%M:%S")
# 路径必须是绝对路径，否则识别不到
log_file="/opt/python/GodV_Intranet_docker/log/monitor.log"
restart_sh="/opt/python/GodV_Intranet_docker/tools/restart_scan.sh"

# 检查Python进程是否在运行中
pid=`ps -aux | grep scan_start.py | grep -v grep  | awk '{print $2}'`
if [ -n "$pid" ] ; then
        echo "$current_time scan_start.py is running" && echo "$current_time scan_start.py is running" >> "$log_file"
else
        echo "$current_time scan_start.py is done" && echo "$current_time scan_start.py is done" >> "$log_file"
        echo "$current_time restart scan_start process" && echo "$current_time restart scan_start process" >> "$log_file"
        # setsid nohup python3 /opt/python/GodV_Intranet_docker/scan_start.py >> /opt/python/GodV_Intranet_docker/nohup.out 2>&1 &
        # run restart_scan.sh
        $restart_sh
fi

