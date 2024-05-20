#!/bin/bash


# # # > 参考 
# ip=$(curl -4 -s -X GET http://checkip.amazonaws.com --max-time 10)
# > 
# ip=$(curl -s http://ipv4.icanhazip.com)
# # 备用
# # ip=$(curl -s https://api.ipify.org)
# > 
# CURRENT_TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
# INTERFACE_IP=`ip address show eth0 | grep eth0 | grep global | awk '{print$2}'`
# DNS_RECORD_IP=`dig ${DOMAIN} | grep "${DOMAIN}" | grep -v ';' | awk '{print$5}'`

# echo -e "\n$CURRENT_TIMESTAMP $ip" >> /root/ddns_ip_list.txt


current_time=$(date +"%Y-%m-%d %H:%M:%S")
# output_dir="$(mktemp -d)"
output_dir="/root"

# 1. **环境变量问题**：`cron` 执行时的环境变量与手动执行时的环境变量不同。`cron` 默认的环境变量非常有限，因此可能缺少某些必要的环境配置。 
# 使用绝对路径执行命令 
qnode_output=$(cd /root/ceremonyclient/node && /root/go/bin/qnode -node-info)

# current_max_frame=$(echo "$output" | grep -oP 'Max Frame: \K\d+')
max_frame=$(echo "$qnode_output" | grep -P 'Max Frame:')

# echo -e "\n\n==> Quil Node Info \n$current_time: \n$output" >> "$output_dir/quil_node-info.log"

# echo -e "\n\n==> $current_time \nQuil Node Info: \n$output" >> "$output_dir/quil_node-info.log"

# -e 是 echo 命令的一个选项参数,它的作用是允许 echo 能够解释和显示转义字符。 
echo -e "\n\n$current_time \n$max_frame <== " >> "$output_dir/quil_node-info.log"

