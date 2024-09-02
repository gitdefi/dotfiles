# DD系统脚本

在原大佬(leitbogioro)的基础上，我们增加了随机端口和随机密码功能，使系统更加安全。本脚本默认安装 Debian 12 系统。

## 功能介绍

本脚本的主要功能包括：
1. 下载并执行 DD 系统安装脚本。
2. 生成随机的 SSH 端口（1024 到 65535 之间）。
3. 生成随机的系统密码（24 个字符，包含大小写字母和数字）。
4. 自动设置时区为 "Asia/Hong_Kong"。

## 使用方法

请按照以下步骤操作：

1. **下载脚本并赋予执行权限**

   ```bash
   wget --no-check-certificate -qO random_install.sh 'https://raw.githubusercontent.com/ridaiqianhe/dd/main/random_install.sh' && chmod +x random_install.sh && ./random_install.sh
