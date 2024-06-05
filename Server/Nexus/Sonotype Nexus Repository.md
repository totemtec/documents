# CentOS 7 安装 Nexus 仓库

### 依赖 Docker


```bash
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
```

带持久化目录的运行命令

```bash
$ mkdir -p /opt/nexus/data && chown -R 200 /opt/nexus/data
$ docker run -d -p 8081:8081 --name nexus -v /opt/nexus/data:/nexus-data -e INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx4096m -XX:MaxDirectMemorySize=4096m -Djava.util.prefs.userRoot=/nexus-data/javaprefs" sonatype/nexus3
```

### 停止时，请确保留出足够的时间让数据库完全关闭

```bash
docker ps
docker stop --time=120 <CONTAINER_NAME>
```

### 查看运行日志

```bash
docker logs -f nexus
```

### 错误排查

1.  ConnectTimeoutException: Connect to sonatype-download.global.ssl.fastly.net

解决方法：管理员登录，`Setting` -> `System` -> `Capabilities` -> 选择状态不对的条目比如 `Outreach: Management` -> `Disable`

然后重启即可

参考文档
> https://github.com/sonatype/docker-nexus3
> https://www.mintimate.cn/2023/06/24/hostMirrorByNexus/

### npm 使用

```bash
# 清理缓存
npm cache clean -f

# 设置使用的源
npm config set registry http://172.28.103.161:8081/repository/npm-public/

# 删除已经安装的依赖，Windows 版本
rd -r node_modules

# 删除已经安装的依赖，Linux 版本
rm -rf node_modules

# 重新安装依赖
npm install
```