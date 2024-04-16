# 数据库服务器修改编码使用utf8mb4

**utf8mb4支持emoji表情字符，以后请不要使用utf8**

### 1. 查询现有编码
```
mysql> SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';
```

### 2. 修改MySQL服务器配置文件，加入下面几行内容
```
# vi /etc/my.cnf
```

**以下为配置内容：**
```
# 对本地的mysql客户端的配置
[client]
default-character-set = utf8mb4
 
# 对其他远程连接的mysql客户端的配置
[mysql]
default-character-set = utf8mb4
 
# 本地mysql服务的配置
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_520_ci
```

**如果排序编码不支持utf8mb4_unicode_520_ci，可以使用 utf8mb4_unicode_ci**

### 3. 重启mysqld
```
# systemctl stop mysqld
 
# systemctl start mysqld
```

### 4. 再次进入查询
```
mysql> SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';
 
+--------------------------+------------------------+
| Variable_name            | Value                  |
+--------------------------+------------------------+
| character_set_client     | utf8mb4                |
| character_set_connection | utf8mb4                |
| character_set_database   | utf8mb4                |
| character_set_filesystem | binary                 |
| character_set_results    | utf8mb4                |
| character_set_server     | utf8mb4                |
| character_set_system     | utf8                   |
| collation_connection     | utf8mb4_unicode_520_ci |
| collation_database       | utf8mb4_unicode_520_ci |
| collation_server         | utf8mb4_unicode_520_ci |
+--------------------------+------------------------+
10 rows in set (0.00 sec)
```
**注：character_set_system 一直都会是 utf8，不能被更改**

# 已有数据库修改编码为utf8mb4

### 1. 查看现有编码

查看database的字符编码
```
mysql> show create database DATABASE_NAME;
```
查看table的字符编码
```
mysql> show create table TABLE_NAME;
```
查看column的字符编码
```
mysql> show full columns from COLUMN_NAME;
```

### 2. 修改database默认的字符集
```
mysql> ALTER DATABASE polarsnow CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci;
 
Query OK, 1 row affected (0.03 sec)
```

### 3. 修改table的字符集

只修改表默认的字符集
```
mysql> ALTER TABLE table_name DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
```

修改表默认的字符集和所有字符列的字符集 
```
mysql> ALTER TABLE table_name CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
```

### 4. 修改column默认的字符集
```
mysql> ALTER TABLE table_name CHANGE column_name column_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
```

### 5. 修复&优化所有数据表
```
# mysqlcheck -u root -p --auto-repair --optimize --all-databases
```