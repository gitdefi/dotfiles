#!/bin/bash

# 生成随机密码（12个字符，包含大小写字母和数字）
PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c12)

# 生成随机端口（1024到65535之间）
PORT=$((RANDOM%64512+1024))

# 下载并设置脚本
wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh

# 执行脚本并传入参数
bash InstallNET.sh -debian 12 -timezone "Asia/Hong_Kong" -port "$PORT" -pwd "$PASSWORD"

# 检查 WARP 状态并获取 IP 地址
WgcfIPv4Status=$(curl -s4m8 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
WgcfIPv6Status=$(curl -s6m8 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)

if [[ $WgcfIPv4Status =~ "on"|"plus" ]] || [[ $WgcfIPv6Status =~ "on"|"plus" ]]; then
    wg-quick down wgcf >/dev/null 2>&1
    systemctl stop warp-go >/dev/null 2>&1
    v6=$(curl -s6m8 api64.ipify.org -k)
    v4=$(curl -s4m8 api64.ipify.org -k)
    wg-quick up wgcf >/dev/null 2>&1
    systemctl start warp-go >/dev/null 2>&1
else
    v6=$(curl -s6m8 api64.ipify.org -k)
    v4=$(curl -s4m8 api64.ipify.org -k)
fi

# 输出随机生成的密码和端口，以及 IP 地址
echo "Generated Password: $PASSWORD"
echo "Generated Port: $PORT"
echo "IPv4 Address: $v4"
echo "IPv6 Address: $v6"

echo "SSH configuration updated. You can now connect using:"
echo "ssh root@$v4 -p $PORT"
echo "请手动执行：reboot"
