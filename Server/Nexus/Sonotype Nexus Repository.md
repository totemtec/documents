# CentOS 7 安装 Nexus Docker 版

参考文档
> https://www.mintimate.cn/2023/06/24/hostMirrorByNexus/
> https://github.com/sonatype/docker-nexus3

### 安装 Docker

略

### 简单运行镜像
```bash
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
```

### 带参数生产环境运行命令

带持久化目录的运行命令

```bash
$ mkdir -p /opt/nexus/data && chown -R 200 /opt/nexus/data

$ docker run -d -p 8081:8081 --name nexus -v /opt/nexus/data:/nexus-data -e INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx4096m -XX:MaxDirectMemorySize=4096m -Djava.util.prefs.userRoot=/nexus-data/javaprefs" sonatype/nexus3
```

mkdir -p /opt/nexus2/data && chown -R 200 /opt/nexus2/data
docker run -d -p 8082:8081 --name nexus2 -v /opt/nexus2/data:/nexus-data --ulimit nofile=65536:65536 -e INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx4096m -XX:MaxDirectMemorySize=4096m -Djava.util.prefs.userRoot=/nexus-data/javaprefs" sonatype/nexus3



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
