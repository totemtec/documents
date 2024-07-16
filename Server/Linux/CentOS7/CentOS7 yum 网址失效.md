### 问题描述

yum install 时出错

Could not resolve host: mirrorlist.centos.org; Unknown error

### 解决方法

```bash
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
```

### 使用代理

```bash
vi /etc/yum.conf
```

加入一行

```bash
proxy=http://172.28.100.33:15732
```