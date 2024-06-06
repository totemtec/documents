### Nexus 创建 npm 镜像

参考文档
> https://www.mintimate.cn/2023/06/24/hostMirrorByNexus/

也可以查看本目录下 PDF，内容同上

### npm 先清理一下项目依赖和缓存

```bash
# 清理缓存
npm cache clean --force

# 查看 Cache 目录
npm cache verify
npm config get cache

# 清理下列目录，如果有的话
用户主目录/npm-cache
用户主目录/.npm

# 删除已经安装的依赖，Windows 版本
rd -r node_modules

# 删除已经安装的依赖，Linux 版本
rm -rf node_modules

# 删除
rm package-lock.json

```

### npm 重新安装依赖

- 方式 1，修改默认镜像

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

如果只是这个项目使用，可以创建 $PROJECT_HOME/.npmrc，内容同上。

但是这样有个问题，比如 npm 缓存了某个包，这个包就不会经过内网镜像，内网镜像就没法缓存这个包

- 方式 2，每次安装指定镜像

```bash
# 安装
npm install --registry http://172.28.103.161:8081/repository/npm-public/
```

- 安装完成后，确认已经被缓存

浏览器访问镜像仓库，确认自己的依赖包已经被缓存

> http://172.28.103.161:8081/#browse/browse:npm-public