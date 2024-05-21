#!/bin/bash


# 300 1800

# 900 4500


# apt update && apt-get update
# apt install -y net-tools ifupdown


output_dir="$(mktemp -d)"
last_max_frame=0
timer=0
restart_times=1

while true; do
   current_time=$(date +"%Y-%m-%d %H:%M:%S")
   output=$(cd ~/ceremonyclient/node && qnode -node-info)
   current_max_frame=$(echo "$output" | grep -oP 'Max Frame: \K\d+')

   echo "$current_time: $output" >> "$output_dir/output.log"

   if [ "$current_max_frame" -gt "$last_max_frame" ]; then
       last_max_frame="$current_max_frame"
       timer=0
   else
       timer=$((timer+900))
       if [ "$timer" -ge 4500 ]; then
           systemctl stop ceremonyclient.service
           sleep 20
           sudo ifdown eth0 && sudo ifup eth0
           sleep 20
           systemctl daemon-reload
           sleep 20
           systemctl start ceremonyclient.service
           echo "在 $current_time 时节点区块高度为: $current_max_frame , 90分钟过后 , 节点区块高度仍未变化 节点已重启 , 至此 节点累计重启 $restart_times 次 "
           restart_times=$((restart_times+1))
           timer=0
       fi
   fi

   sleep 900
done

