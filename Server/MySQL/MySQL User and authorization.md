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
```
mysql> GRANT ALL PRIVILEGES ON database.* TO 'username'@'%' IDENTIFIED BY 'password';
```

MySQL 8.0 以上使用下面语句进行授权
```
GRANT ALL ON database.* TO 'username'@'%' WITH GRANT OPTION;
```

### 4. 刷新生效授权
```
mysql> FLUSH PRIVILEGES;
```

# MySQL权限管理实例

授予username用户在本地连接访问所有数据库的所有权限
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' IDENTIFIED BY 'password';
```

主机使用百分号%，这样从别的任何地方都可以连接
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'username'@'％' IDENTIFIED BY 'password';
```

撤销username用户在本地连接访问所有数据库的所有授权
```
mysql> EVOKE ALL PRIVILEGES ON *.* FROM 'username'@'localhost';
```

指定该用户只能执行 select 和 update 命令
```
mysql> GRANT SELECT, UPDATE ON wordpress.* TO 'username'@'localhost' IDENTIFIED BY 'password';
```

删除刚才创建的用户
```
DROP USER username@localhost;
```

不管是授权，还是撤销授权，都要指定相应的host 

因为以上几个命令实际上都是在操作mysql数据库中的user表，可以用如下命令查看用户及对应的host

```
mysql> SELECT User, Host FROM user;
```

修改用户密码
```
ALTER USER 'username' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```
**user表中还包含很多其它例如用户密码、权限设置等很多内容，操作时候尤其需要小心。**
