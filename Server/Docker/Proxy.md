# Docker 使用代理

参考文档

> https://docs.docker.com/config/daemon/proxy/#httphttps-proxy


```bash
vi /etc/docker/daemon.json

{
    "proxies": {
        "http-proxy": "http://172.28.100.33:15732",
        "https-proxy": "http://172.28.100.33:15732",
        "no-proxy": "*.test.example.com,.example.org,127.0.0.0/8"
    }
}
```