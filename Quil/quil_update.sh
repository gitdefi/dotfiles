#!/bin/bash


# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi


# Step 0: Welcome
echo "⏳Enjoy and sit back while you are upgrading your Quilibrium Node to v1.4.18!"
echo "⏳Processing..."
sleep 10  # Add a 10-second delay

# Stop the ceremonyclient service
# service ceremonyclient stop

systemctl stop ceremonyclient.service
# # systemctl stop ceremonyclient.service || true


# Step 1:Download Binary
echo "⏳ Downloading New Release v1.4.18"
cd  ~/ceremonyclient
git pull
sleep 10
git checkout release


# Step 3:Re-Create Ceremonyclient Service
echo "⏳ Re-Creating Ceremonyclient Service"
sleep 2  # Add a 2-second delay
rm -f /lib/systemd/system/ceremonyclient.service
# sudo tee /lib/systemd/system/ceremonyclient.service > /dev/null <<EOF
# [Unit]
# Description=Ceremony Client Go App Service

# [Service]
# Type=simple
# Restart=always
# RestartSec=5s
# WorkingDirectory=/root/ceremonyclient/node
# ExecStart=/root/ceremonyclient/node/node-1.4.18-linux-amd64

# [Install]
# WantedBy=multi-user.target
# EOF


# cat > /lib/systemd/system/ceremonyclient.service <<EOF
# [Unit]
# Description=Ceremony Client Go App Service
# [Service]
# Type=simple
# Restart=always
# RestartSec=5s
# WorkingDirectory=/root/ceremonyclient/node
# Environment=GOEXPERIMENT=arenas
# ExecStart=/root/ceremonyclient/node/node-1.4.18-linux-amd64 ./...
# [Install]
# WantedBy=multi-user.target
# EOF


# # # > 限制 CPU 使用率 
cat > /etc/systemd/system/ceremonyclient.service <<EOF
[Unit]
Description=Ceremony Client Go App Service
[Service]
Slice=ceremonyclient.slice
Type=simple
Restart=always
RestartSec=5s
WorkingDirectory=/root/ceremonyclient/node
Environment=GOEXPERIMENT=arenas
ExecStart=/root/ceremonyclient/node/node-1.4.18-linux-amd64 ./...
[Install]
WantedBy=multi-user.target
EOF

numcpu=$(/usr/bin/nproc)

quota=$((numcpu * 75))

sleep 5

cat > /etc/systemd/system/ceremonyclient.slice <<EOF
[Slice]
CPUQuota=${quota}%
EOF


# # # > 
cd
crontab -l
rm -f /root/quil_monitor_node-info.sh
sleep 5
wget https://raw.githubusercontent.com/gitdefi/dotfiles/main/Quil/quil_monitor_node-info.sh
sleep 10
chmod +x /root/quil_monitor_node-info.sh

# echo "@reboot sleep 20 && /root/disable-ipv6.sh" > /tmp/crontab.tmp; echo "@reboot sleep 1800 && /root/quil_monitor_node-info.sh" >> /tmp/crontab.tmp; crontab /tmp/crontab.tmp; rm -f /tmp/crontab.tmp


# (
#   sudo crontab -u root -l 2>/dev/null
#   echo "@reboot sleep 1800 && /root/quil_monitor_node-info.sh"
# ) | sudo crontab -u root -


# screen -dmS jk
# screen -S jk -X stuff "/root/quil_monitor_node-info.sh\n"
# screen -ls
# crontab -l


# # # > 


# Step 4:Start the ceremonyclient service
echo "✅ Starting Ceremonyclient Service"
sleep 2  # Add a 2-second delay
systemctl daemon-reload
sleep 10
# systemctl enable ceremonyclient
# service ceremonyclient start


# See the logs of the ceremonyclient service
echo "🎉 Welcome to Quilibrium Ceremonyclient v1.4.18"
echo "⏳ Please let it flow node logs at least 5 minutes then you can press CTRL + C to exit the logs."
sleep 5  # Add a 5-second delay
# sudo journalctl -u ceremonyclient.service -f --no-hostname -o cat


# # Qclient Install 
# rm /root/go/bin/qclient
# cd ~/ceremonyclient/client
# screen -dmS goqclient
# sleep 5
# screen -S goqclient -X stuff "GOEXPERIMENT=arenas go build -o /root/go/bin/qclient main.go\n"
# echo "$(ls -laht /root/go/bin)"
# echo "screen -ls $(screen -ls)"

# # qclient token balance
# # qclient token coins
# # qclient cross-mint


/sbin/reboot

