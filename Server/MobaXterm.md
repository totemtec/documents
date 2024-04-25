# MobaXterm 24 使用问题

### session 添加 ssh 服务器后无法连接 session，黑屏

- Edit session
  - Advanced SSH settings
    - Expert SSH settings
      - SSH protocol version 选择 SSHv2
- OK 保存

### MobaXterm 提示32位兼容性问题，提示升级到最新的64位

直接升级，升级后注册信息依然可用，至少版本 24 测试没问题


### MobaXterm 如果使用密钥登录

需要指定私钥文件位置

- Edit session
  - Advanced SSH settings
    - 选中 `Use private key`，并且选择私钥的位置，一般位于 USER_HOME/.ssh/id_rsa
- OK 保存