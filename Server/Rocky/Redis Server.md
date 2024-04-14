# Rocky 9 安装 Redis 最新版

### 安装 Remi 仓库
```
# dnf config-manager --set-enabled crb

# dnf install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm

# dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
```


### 查看
```
# dnf module list redis
```


### 选择版本
```
# dnf module enable redis:remi-7.2 -y
```

### 安装
```
# dnf install redis
```

### 配置启动
```
# systemctl start redis
# systemctl enable redis
```

### 修改监听配置和密码

修改配置文件  `/etc/redis/redis.conf`
```
# 修改为接受所有主机的请求，注释掉下面一句就可以了
# bind 127.0.0.1 -::1

# 修改为需要密码
requirepass 'YOUR_PASSWORD'
```