# CentOS 7 安装 Nexus 仓库

### 依赖 Docker


```bash
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
```

带持久化目录的运行命令

```bash
$ mkdir -p /opt/nexus/data && chown -R 200 /opt/nexus/data
$ docker run -d -p 8081:8081 --name nexus -v /opt/nexus/data:/nexus-data -e INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx4096m -XX:MaxDirectMemorySize=4096m" sonatype/nexus3
```

参考文档
> https://github.com/sonatype/docker-nexus3
> https://www.mintimate.cn/2023/06/24/hostMirrorByNexus/