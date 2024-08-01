# Simulator Debug Code Server

参考文档：

https://hub.docker.com/r/codercom/code-server

### 准备工作区

```bash
rm -rf ~/workspace/coder/*
mkdir -p ~/workspace/coder/project
mkdir -p ~/workspace/coder/.config
```

### 启动命令

```bash
docker run -itd --name sim-debug -p 127.0.0.1:8080:8080 \
  -v "$HOME/workspace/coder/.config:/home/coder/.config" \
  -v "$HOME/workspace/coder/project:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  codercom/code-server:latest
---



docker run -it -d --name ji001 \
-p 11001:8080 -p 11002:54321 \
-v /nfs/home/jizitao/software/codeServer/coder/.config:/home/coder/.config \
-v /nfs/home/jizitao/software/codeServer/coder/project:/home/coder/project \
sim-debug:1.0.0