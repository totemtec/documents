# 安装 Maven 3

> https://maven.apache.org/install.html

### 下载

```
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
```

### 解压
```
tar xzvf apache-maven-3.9.6-bin.tar.gz
```

### 移动
```
mv apache-maven-3.9.6 /opt/
```

### 配置PATH
```
vi ~/.bashrc
```

PATH 加入路径，指向 /opt/apache-maven-3.9.6/bin
```
PATH=$PATH:/opt/apache-maven-3.9.6/bin

export PATH
```

### 测试

ssh 退出重新连接后

```
mvn -v
```

显示如下：
```
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/apache-maven-3.9.6
Java version: 1.8.0_202, vendor: Oracle Corporation, runtime: /usr/java/jdk1.8.0_202-amd64/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "5.4.119-20.0009.29", arch: "amd64", family: "unix"
```
