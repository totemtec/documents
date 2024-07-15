
```bash
sudo openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -keyout ./private.key -out ./cert.crt
```

-  openssl 命令行工具
-  req -x509 指定我们要使用 X.509 证书签名请求 (CSR) 管理
-  -nodes 跳过使用密码保护证书的选项
-  -days 365 证书被视为有效的时间长度
-  -newkey rsa:2048 指定我们要同时生成新证书和新密钥
-  -keyout 私钥文件放在哪里
-  -out 证书放在哪里



```bash
sudo openssl dhparam -out ./cert.pem 2048
```