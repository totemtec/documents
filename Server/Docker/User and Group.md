# Docker 用户组管理

### 查看 `docker` 组的用户

```bash
$ grep 'docker' /etc/group
```

### 将用户 `majianglin` 加入 `docker` 组，加入完成后可以使用上面命令确认一下

```bash
$ sudo usermod -aG docker majianglin
```

### 重启 `docker` 服务

```bash
$ sudo systemctl restart dockerd
```