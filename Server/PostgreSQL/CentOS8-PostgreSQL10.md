# CentOS 8 安装 PostgreSQL 10.x

### 查看 PostgreSQL 版本

```bash
dnf --showduplicates list postgresql
dnf --showduplicates list postgresql-server
```

### 安装 10.x

```bash
dnf install postgresql
dnf install postgresql-server
```

### 初始化和配置数据库

```bash
postgresql-setup --initdb
systemctl enable postgresql
systemctl start postgresql
```

###  超级用户登陆数据库

```bash
su - postgres

psql -U postgres
```
提示符变为：`postgres=#`

###  操作数据库和权限

```sql
CREATE DATABASE tipdm_dev;
CREATE USER tipdm_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE tipdm_dev TO tipdm_user;
\q
```

### 设置远程访问

vi /var/lib/pgsql/data/pg_hba.conf

添加最后一行
```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:  修改为 md5
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 ident
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            ident
host    replication     all             ::1/128                 ident
# 新增下面一行
host    all             all             0.0.0.0/0               trust
```

vi /var/lib/pgsql/data/postgresql.conf

去掉注释，修改为 *
```
listen_addresses = '*'          # what IP address(es) to listen on;
```