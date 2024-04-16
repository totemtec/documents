# CentOS 7 安装 Java 8 u202 

下载
jdk-8u202-linux-x64.rpm

```
rpm -Uvh jdk-8u131-linux-x64.rpm
vi /etc/profile
```

# add follows to the end of file /etc/profile
```
export JAVA_HOME=/usr/java/default
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
```

```
source /etc/profile
java -version
```