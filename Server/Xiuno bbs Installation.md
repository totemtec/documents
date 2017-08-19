# Xiuno 4.0 安装

# 1. 安装NGINX1.12
# 2. 安装PHP7.1
# 3. 安装MySQL5.7

# 4. 安装autoconf
```
# wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
# tar zxf autoconf-2.69.tar.gz
# cd autoconf-2.69
# ./configure 
# make
# make install
```

# 5. 安装Yac
```
# wget http://pecl.php.net/get/yac-2.0.2.tgz
# tar zxf yac-2.0.2.tgz
# cd yac-2.0.2         一定要在这个目录里
# /usr/bin/phpize
# ./configure --with-php-config=/usr/bin/php-config
# make
# make test
# make install
 
Installing shared extensions:     /usr/lib64/php/modules/
```
进目录 /usr/lib64/php/modules/ 看看yac.so是否编译成功

# 6. 修改配置

```
# vi /etc/php.d/opcache.ini
```
修改下面配置内容
```
opcache.enable_cli=1
opcache.file_cache=/dev/shm
```

```
# vi /etc/php.d/yac.ini
```
新增下面配置内容
```
extension=yac.so

yac.enable = 1
yac.keys_memory_size = 4M
yac.values_memory_size = 64M
yac.compress_threshold = -1
yac.enable_cli = 0
```

# 7. 重新启动php-fpm

写一个phpinfo.php，访问一下看看其中的php配置内容是否OK

```php
<?php
phpinfo();
?>
```