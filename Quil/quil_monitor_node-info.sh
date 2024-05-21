#!/bin/bash


# 300 1800

# 900 4500


# apt update && apt-get update
# apt install -y net-tools ifupdown


# # > output_dir="$(mktemp -d)"
output_dir="/root"
last_max_frame=0
timer=0
restart_times=1

while true; do
   current_time=$(date +"%Y-%m-%d %H:%M:%S")
   qnode_output=$(cd /root/ceremonyclient/node && /root/go/bin/qnode -node-info)
   current_max_frame=$(echo "$qnode_output" | grep -oP 'Max Frame: \K\d+')
   log_max_frame=$(echo "$qnode_output" | grep -P 'Max Frame:')

   # # > echo "$current_time: $qnode_output" >> "$output_dir/output.log"
   # -e 是 echo 命令的一个选项参数,它的作用是允许 echo 能够解释和显示转义字符。 
   echo -e "\n\n$current_time \n$log_max_frame <== " >> "$output_dir/quil_monitor_node-info.log"

   if [ "$current_max_frame" -gt "$last_max_frame" ]; then
       last_max_frame="$current_max_frame"
       timer=0
   else
       timer=$((timer+900))
       if [ "$timer" -ge 4500 ]; then
           systemctl stop ceremonyclient.service
           sleep 30
           # # > sudo ifdown eth0 && sudo ifup eth0
           # # > sleep 20
           # # > systemctl daemon-reload
           # # > sleep 20
           # # > systemctl start ceremonyclient.service
           current_time=$(date +"%Y-%m-%d %H:%M:%S")
           echo -e "\n\n在 $current_time 时 节点区块高度为: $current_max_frame , 已等待90分钟 , 节点区块高度仍未变化 系统将于30秒后重启 , 至此 节点累计重启 $restart_times 次 <== " >> "$output_dir/quil_monitor_node-info.log"
           restart_times=$((restart_times+1))
           timer=0
           sleep 30
           /sbin/reboot
       fi
   fi

   sleep 900
done


