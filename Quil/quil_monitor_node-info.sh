#!/bin/bash


# 300 1800 s

# 900 4500 s

# 900 9000 s


# apt update && apt-get update
# apt install -y net-tools ifupdown


# # > output_dir="$(mktemp -d)"
output_dir="/root"
last_current_frame=0
timer=0
restart_times=1

while true; do
   # 获取最近 15 分钟内的 "current_frame" 数值 
   qnode_output=$(/usr/bin/journalctl -u ceremonyclient.service --since '15 minutes ago' --no-hostname -o cat | grep -oP '"current_frame":\K\d+')
   # 如果有输出
   if [ -n "$qnode_output" ]; then
       # 将输出分割成行,并获取第一行和最后一行 
       first_current_frame=$(echo "$qnode_output" | head -n 1)
       last_current_frame=$(echo "$qnode_output" | tail -n 1)
       # # log_max_frame=$(echo "$qnode_output" | grep -P 'Max Frame:')
       # 
       # # > echo "$current_time: $qnode_output" >> "$output_dir/output.log"
       current_time=$(date +"%Y-%m-%d %H:%M:%S")
       # -e 是 echo 命令的一个选项参数,它的作用是允许 echo 能够解释和显示转义字符。 
       echo -e "\n\n$current_time \n"current_frame":$last_current_frame <== " >> "$output_dir/quil_monitor_node-info.log"
   else
       echo -e "\n\nNo 'current_frame' values found in the logs. <== " >> "$output_dir/quil_monitor_node-info.log"
   fi

   # 比较第一行和最后一行的数值大小 
   # 如果 $last_current_frame 变量的值大于 $first_current_frame 变量的值,则执行 then 后面的代码块。
   if [ "$last_current_frame" -gt "$first_current_frame" ]; then
       # # last_current_frame="$first_current_frame"
       timer=0
   else
       timer=$((timer+900))
       if [ "$timer" -ge 9000 ]; then
           systemctl stop ceremonyclient.service
           sleep 30
           # # > sudo ifdown eth0 && sudo ifup eth0
           # # > sleep 20
           # # > systemctl daemon-reload
           # # > sleep 20
           # # > systemctl start ceremonyclient.service
           # 
           output_log=$(cat /root/quil_monitor_node-info.log | grep -oP 'restart_times=\K\d+')
           # 如果有输出
           if [ -n "$output_log" ]; then
               # 将输出分割成行,并获取最后一行 
               # # first_current_frame=$(echo "$output_log" | head -n 1)
               restart_times=$(echo "$output_log" | tail -n 1)
               # 
               restart_times=$((restart_times+1))
               current_time=$(date +"%Y-%m-%d %H:%M:%S")
               # -e 是 echo 命令的一个选项参数,它的作用是允许 echo 能够解释和显示转义字符。 
               echo -e "\n\n$current_time \nrestart_times=$restart_times <== " >> "$output_dir/quil_monitor_node-info.log"
           else
               restart_times=1
               current_time=$(date +"%Y-%m-%d %H:%M:%S")
               echo -e "\n\n$current_time \nrestart_times=$restart_times <== " >> "$output_dir/quil_monitor_node-info.log"
           fi
           current_time=$(date +"%Y-%m-%d %H:%M:%S")
           echo -e "\n\n在 $current_time 时 节点区块高度为: $first_current_frame , 已等待150分钟 , 节点区块高度仍未变化 系统将于30秒后重启 , 至此 节点累计重启 $restart_times 次 <== " >> "$output_dir/quil_monitor_node-info.log"
           restart_times=$((restart_times+1))
           timer=0
           sleep 30
           /sbin/reboot
       fi
   fi

   sleep 900
done


# # # > 


# #!/bin/bash

# # 获取最近 15 分钟内的 "current_frame" 数值 
# output=$(/usr/bin/journalctl -u ceremonyclient.service --since '15 minutes ago' --no-hostname -o cat | grep -oP '"current_frame":\K\d+')

# # 如果有输出
# if [ -n "$output" ]; then
#     # 将输出分割成行,并获取第一行和最后一行 
#     first_line=$(echo "$output" | head -n 1)
#     last_line=$(echo "$output" | tail -n 1)

#     # 比较第一行和最后一行的数值大小 
#     # 如果 $last_line 变量的值大于 $first_line 变量的值,则执行 then 后面的代码块。 
#     if [ "$last_line" -gt "$first_line" ]; then
#         # 记录时间戳和最后一行的数值到文件 
#         timestamp=$(date '+%Y-%m-%d %H:%M:%S')
#         echo "$timestamp: Last frame number = $last_line" >> ~/quil_monitor_node-info.log
#     fi
# else
#     echo "No 'current_frame' values found in the logs."
# fi

