# Docker 国内加速

参考文档

> https://gist.github.com/y0ngb1n/7e8f16af3242c7815e7ca2f0833d3ea6


创建或修改 `/etc/docker/daemon.json`：

```bash
cd /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://mirror.iscas.ac.cn",
        "https://dockerproxy.com/",
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

### Docker Hub 镜像测速

使用镜像前后，可使用 time 统计所花费的总时间。测速前先移除本地的镜像！

```bash
$ docker rmi node:latest
$ time docker pull node:latest
```

输出

```
Pulling repository node
[...]

real   1m14.078s
user   0m0.176s
sys    0m0.120s
```