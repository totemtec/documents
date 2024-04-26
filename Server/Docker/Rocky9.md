# Rocky9 安装 Docker

官方文档

https://docs.docker.com/engine/install/centos/

### 删除旧版本

```bash
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine
```

### 设置 yum 仓库

```bash
sudo yum install -y yum-utils && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### 安装最新版

```bash
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 安装其他版本

```bash
yum list docker-ce --showduplicates | sort -r

sudo yum install docker-ce-3:25.0.0-1.el8 docker-ce-cli-3:25.0.0-1.el8 containerd.io docker-buildx-plugin docker-compose-plugin
```

### 启动 Docker

```bash
sudo systemctl start docker
```

### 运行 hello-world 镜像

```bash
sudo docker run hello-world
```