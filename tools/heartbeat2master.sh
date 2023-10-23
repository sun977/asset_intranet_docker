#!/bin/bash
# author: sun977
# use: heartbeat to master node
# date: 2023-10-08

current_time=$(date +"%Y-%m-%d %H:%M:%S")
log_file="/opt/python/GodV_Intranet_docker/log/monitor.log"
Master_URL="http://10.95.58.94:8077/api/v1/heartbeat" #请求的URL
APIKEY="apikey@admin123"
HOSTNAME=$(hostname)

JSON='{"scannerip": "0.0.0.0", "scannerhost": "'"$HOSTNAME"'", "apikey": "'"$APIKEY"'", "is_use": "1", "is_alive": "ok"}'

STATUS=$(curl -s -X POST -H "Content-Type: application/json" -d "$JSON" "$Master_URL" | awk -F ":" '{gsub(/"/, "", $0); print $2}' | awk -F "," '{print $1}')
#echo "$STATUS"

if [ -z "$STATUS" ]; then
  echo "$current_time API STATUS is null" >> "$log_file"
else
  echo "$current_time API STATUS is not null" >> "$log_file"
  if [ "$STATUS" -eq 2000 ]; then
    echo "$current_time Received 2000 status, heartbeat success"
    # echo "$current_time Received 2000 status, heartbeat success" >> "$log_file"
  else
    echo "$current_time Received response with status $STATUS, heartbeat failed"
    # echo "$current_time Received response with status $STATUS, heartbeat failed" >> "$log_file"
  fi
fi

# curl -X POST -H "Content-Type: application/json" -d '{
#    "scannerip": "0.0.0.0",
#    "scannerhost": "vnode",
#    "apikey": "apikey@admin123",
#    "is_use":"2",
#    "is_alive": "ok"
#}' http://127.0.0.1:8077/api/v1/heartbeat
#{
#  "code": "2000",
#  "msg": "new scanner node add success"
#}