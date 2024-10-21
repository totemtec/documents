# 安装 MySQL 5.7 Community Server On CentOS 7

### 参考文档
> https://dev.mysql.com/doc/mysql-repo-excerpt/5.7/en/linux-installation-yum-repo.html

### 1. 下载mysql的官方源
```
# wget https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm
```
> 可以在https://dev.mysql.com/downloads/repo/yum/找到下载地址

### 2. 安装mysql57-community-release-el7-11.noarch.rpm包
```
# yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
```

### 3. 安装这个包后，查看获得的mysql的yum仓库
```
# ls -1 /etc/yum.repos.d/mysql-community*
 
/etc/yum.repos.d/mysql-community.repo
/etc/yum.repos.d/mysql-community-source.repo

# rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
```

如果后续安装出现 GPG 校验错误，可以关掉 GPG 校验

```
vi /etc/yum.repos.d/mysql-community.repo

[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0   这里修改为 0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
```


### 4. 安装mysql服务器
```
# yum install -y mysql-community-server
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
要求输入root密码，使用上面获取的root密码

设置新的root密码，必须包含字母大小写和数字特殊字符，长度最少12位

剩下的提示项全部选Y，选项有

只允许root用户本机登录

删除匿名用户

删除测试数据库

### 8. 测试数据库
```
# mysqladmin -u root -p version
```

### 9. 连接数据库
连接本机数据库
```
# mysql -u root -p
```

连接远程数据库，并指定库名
```
# mysql -u root -p -h 10.172.246.158 -Dcms
```

### 10. 如果需要为mysql打开防火墙，请参考Linux管理文档



# 修改MySQL数据目录


### 1. 停止服务
```
systemctl stop mysqld
```

### 2、移动data目录，好象停止服务前拷贝能保留几个sock和pid临时文件
```
rsync -av /var/lib/mysql /data  后面不能加斜线/，移动后目录是/data/mysql/...
```

备份老文件
```
mv /var/lib/mysql /var/lib/mysql.bak
```

### 3、修改配置文件
```
# vi /etc/my.cnf
```

以下为配置内容：
```
[mysqld]
datadir=/data/mysql
socket=/data/mysql/mysql.sock 
 
# 在[client]中添加socket路径，如果不添加则root用户无法登录：
[client]
socket=/data/mysql/mysql.sock
```

修改完后尝试启动
```
# systemctl start mysqld
```

### 4. 如果无法启动，修改SELinux配置

检查SELinux权限
```
# ls -lZ /var/lib/mysql
```
必须是下面设置才行
drwxr-xr-x. mysql mysql system_u:object_r:mysqld_db_t:s0 mysql

Ensure the user:group is mysql:mysql
Set the SELinux tag to mysqld_db_t
Set the SELinux user to system_u

```
# chcon -Rt mysqld_db_t /data/mysql
# chcon -Ru system_u /data/mysql
# chown -R mysql:mysql /data/mysql
```

或者只使用下面一句
```
# chcon -R -u system_u -r object_r -t mysqld_db_t /data/mysql
```


### 5. 重启试试
```
# systemctl stop mysqld
 
# systemctl start mysqld
```

# 导出数据库
```
# mysqldump -u root -p cms > cms.sql
```
# 导出全部数据库
```
# mysqldump -u root -p --all-databases > all.sql

```

# 导入数据库
首先需要创建数据库
```
mysql> CREATE DATABASE cms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
```
导入
```
# mysql -u root -p cms < cms.sql
```