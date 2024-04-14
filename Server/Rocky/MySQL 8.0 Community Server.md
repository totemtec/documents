# 安装 MySQL 8.0 Community Server

### 参考文档
> https://dev.mysql.com/doc/refman/8.3/en/linux-installation-yum-repo.html

### 1. 下载mysql的官方源
```
# wget https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm
```
> 可以在 https://dev.mysql.com/downloads/repo/yum/ 找到下载地址

### 2. 安装 mysql80-community-release-el9-5.noarch.rpm 包
```
# yum localinstall mysql80-community-release-el9-5.noarch.rpm
```

### 3. 安装这个包后，查看获得的 mysql 的 yum 仓库
```
# yum repolist enabled | grep mysql.*-community
```

输出如下
``` bash
mysql-connectors-community              MySQL Connectors Community
mysql-tools-community                   MySQL Tools Community
mysql80-community                       MySQL 8.0 Community Server
```

### 4. 安装mysql服务器
```
# yum install mysql-community-server
```
**此步骤根据提示安装，下载文件较多，需要耐心等待**

**也可以只安装mysql客户端**
```
# yum install mysql-community-client
```

### 5. 启动MySQL
```
# systemctl start mysqld
```
##### 设置为开机启动
```
# systemctl enable mysqld
```

### 6. 启动完成后，会为root用户生成一个随机密码，可以直接查看log
```
# grep 'temporary password' /var/log/mysqld.log
```

### 7. 拿到密码后执行一个安全脚本
```
# mysql_secure_installation
```
要求输入 root 密码，使用上面获取的 root 密码

设置新的 root 密码，必须包含字母大小写和数字特殊字符，长度最少12位

剩下的提示项全部选 Y，选项有

只允许root用户本机登录

删除匿名用户

删除测试数据库

刷新权限表

### 8. 测试数据库
```
# mysqladmin -u root -p
```

### 9. 连接数据库
连接本机数据库
```
# mysql -u root -p
```

连接远程数据库，并指定库名
```
# mysql -u root -p -h HOST_NAME -D DATABASE_NAME
```