### npm 使用本地镜像

目的是使项目的 `所有依赖包都走本地镜像`，本地镜像的缓存才可以拷贝同步到 内网镜像

参考文档
> https://www.mintimate.cn/2023/06/24/hostMirrorByNexus/

也可以查看本目录下 《Nexus自建镜像.pdf》，内容同上

注意：局域网 IP 可能会被代理，请先关掉代理

### 开发电脑上，npm 先清理一下项目依赖和缓存

```bash
# 清理缓存
npm cache clean --force

# 查看缓存清理结果
npm cache verify

# 查看缓存目录，上述命令执行成功后，可以不用执行这个命令
npm config get cache

# 删除已经安装的依赖，Windows 版本
rd -r node_modules

# 删除已经安装的依赖，Linux 版本
rm -rf node_modules

# 删除
rm package-lock.json
```

Windows 一键清理脚本，在 `项目根目录` 下运行

```bash
npm cache clean --force ; rd -r node_modules ; rm package-lock.json
```

### 全局依赖包可以先删除，再使用本地镜像进行安装

例如

```bash
# 删除
npm uninstall -g @vscode/vsce

# 再安装
npm install -g @vscode/vsce --registry=http://172.28.103.161:8081/repository/npm-public/
```

### npm 重新安装项目依赖

需要在 Linux 上同样的 node 和 npm 版本跑一边，否则有些库有系统依赖，缓存不上

- 方式 1 ：修改 `用户级别` 默认镜像，然后安装

```bash
# 设置使用的源
npm config set registry http://172.28.103.161:8081/repository/npm-public/

# 查看设置是否成功
npm config list
npm config ls -l

# 安装
npm install
```

这样 $USER_HOME/.npmrc 文件中会新增内容

```
registry=http://172.28.103.161:8081/repository/npm-public/
```

- 方式 2 ：修改 `项目级别` 默认镜像。然后安装

如果只是这个项目使用，可以创建 $PROJECT_HOME/.npmrc，内容同上。

```
registry=http://172.28.103.161:8081/repository/npm-public/
```

- 方式 3，每次安装依赖包时，指定镜像

```bash
# 安装
npm install --registry=http://172.28.103.161:8081/repository/npm-public/
```

### 安装完成后，确认缓存

浏览器访问镜像仓库，确认自己的依赖包已经被缓存

> http://172.28.103.161:8081/#browse/browse:npm-public


### 内网使用 npm 需要设置

设置 npm 安装全局依赖时的存储路径，否则权限问题装不上

```bash

mkdir ~/.npm-global

npm config set prefix "~/.npm-global"

vi ~/.bashrc

export PATH=~/.npm-global/bin:$PATH

source ~/.bashrc
```


