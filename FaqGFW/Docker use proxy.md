# Docker 使用代理

参考文档

> https://docs.docker.com/config/daemon/#configure-the-docker-daemon

```bash
sudo vi /etc/docker/daemon.json
```

内容如下

```json
{
  "proxies": {
    "http-proxy": "http://proxy.example.com:3128",
    "https-proxy": "https://proxy.example.com:3129",
    "no-proxy": "*.test.example.com,.example.org,127.0.0.0/8"
  }
}
```