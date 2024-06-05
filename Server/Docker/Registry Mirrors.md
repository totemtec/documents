# Docker 国内加速

参考文档

> https://gist.github.com/y0ngb1n/7e8f16af3242c7815e7ca2f0833d3ea6


创建或修改 `/etc/docker/daemon.json`：

```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://dockerproxy.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://docker.nju.edu.cn"
    ]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

查看结果

```bash
docker info
```