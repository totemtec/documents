# Linux 命令行配置代理

```bash
sudo -H vi /etc/profile.d/proxy.sh
```

内容如下

```
export http_proxy=http://username:password@proxyhost:port/ 
export ftp_proxy=http://username:password@proxyhost:port/
export telnet_proxy=http://username:password@proxyhost:port/
```

保存后，重新登录即可生效
