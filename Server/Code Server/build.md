# 编译打包 Code Server

系统：Ubuntu24
参考文档：https://coder.com/docs/code-server/CONTRIBUTING


### 环境依赖工具

```bash

# node v20.11.1
node --version

git --version

apt udpate

# yarn
# Used to install JS packages and run scripts
npm install -g yarn

# nfpm
# Used to build .deb and .rpm packages
apt install -y nfpm

# jq
# Used to build code-server releases
apt install -y jq

# gnupg
# All commits must be signed and verified
# 系统自带了，也用不上，忽略

# quilt
# Used to manage patches to Code
apt install -y quilt

# rsync and unzip
# Used for code-server releases
apt install -y rsync unzip

# bats
# Used to run script unit tests
apt install -y bats
```

### Linux 依赖

```bash
apt install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev libkrb5-dev python-is-python3
```

### 开发工作流

1. 克隆

```bash
git clone https://github.com/coder/code-server
```

2. 克隆 vscode 子模块

```bash
cd code-server
git submodule update --init
```

3. 应用 patches

```bash
quilt push -a
```

4. 安装依赖

```bash
yarn
```

5. 本地运行。访问 http://localhost:8080

```bash
yarn watch
```


### 编译

```bash
# 这3步可以省略
git submodule update --init
quilt push -a
yarn install

# 执行这3步就可以了
yarn build
VERSION=1.0.0 yarn build:vscode
yarn release
```


### 构建 Docker 镜像

```bash
cd code-server
docker build -f ci/release-image/Dockerfile.simdebug -t sim-debug:1.0.0 .
```

### 启动 Docker

```bash
docker run -itd \
  --name sim-debug2 \
  -p 10003:8080 \
  -v "$HOME/workspace/coder/.config:/home/coder/.config" \
  -v "$HOME/workspace/coder/project:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  sim-debug:1.0.0
```

### 升级，并重新构建


参考文档

https://coder.com/docs/code-server/CONTRIBUTING#version-updates-to-code


1. Version updates to Code
2. Patching Code
3. Build 之前 yarn clean 一下
