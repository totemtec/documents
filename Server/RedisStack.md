# Redis Stack 安装和使用


```bash
vi /etc/yum.repos.d/redis.repo
```

```
[Redis]
name=Redis
baseurl=http://packages.redis.io/rpm/rhel7
enabled=1
gpgcheck=1
```

```bash
curl -fsSL https://packages.redis.io/gpg > /tmp/redis.key
sudo rpm --import /tmp/redis.key
sudo yum install epel-release
sudo yum install redis-stack-server
```

### 配置文件
```
redis.conf
redis-stack.conf
```

### 启停命令
```bash
systemctl start redis-stack-server
systemctl stop redis-stack-server
systemctl restart redis-stack-server
```

### 开机启动
```bash
systemctl enable redis-stack-server
```

### 设置密码
redis-cli 连接上本地服务器以后
```
127.0.0.1:6379> ACL SETUSER default >PASSWORD_TEXT
```
