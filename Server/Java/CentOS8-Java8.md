# CentOS 8 安装 Java 8 u202 

jdk-8u202 后面这个版本后面和其他版本不一样，Oracle仓库里是分开的

### 下载对应版本的安装包

### 安装
```bash
dnf install jdk-8u202-linux-x64.rpm
```

### 修改java默认的加密策略
```
vi /usr/java/default/jre/lib/security/java.security 
```

去掉 crypto.policy=unlimited 的注释即可