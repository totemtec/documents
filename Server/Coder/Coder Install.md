# Coder Install

环境 Ubuntu 24

参考文档

> https://coder.com/docs/install

```bash
# 安装
curl -L https://coder.com/install.sh | sh

# 启动
systemctl start coder

# 如果启动失败是因为缺少 Terraform ，那可以安装一下 Terraform
# 默认 coder 自己会去安装。但是不翻墙会安装失败

```

# 浏览器访问

http://127.0.0.1:3000
