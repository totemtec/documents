# MySQL 数据库管理和用户授权

### 0. 连接数据库

连接本机数据库
```
# mysql -u root -p
```
连接远程数据库
```
# mysql -u root -p -h host_ip
```

### 1. 创建数据库
```
mysql> CREATE DATABASE database CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
```

**建议直接升级utf8bm4，支持emoji表情**

### 2. 创建用户
```
mysql> CREATE USER username IDENTIFIED BY 'password';
```

### 3. 授予权限

MySQL 8.0 以上使用下面语句进行授权
```
GRANT ALL ON database.* TO 'username'@'%' WITH GRANT OPTION;
```

MySQL 5.7 及以下使用下面语句进行授权
```
mysql> GRANT ALL PRIVILEGES ON database.* TO 'username'@'%' IDENTIFIED BY 'password';
```


### 4. 刷新生效授权
```
mysql> FLUSH PRIVILEGES;
```
