# Rocky 9 安装 Java JDK 17

### 安装 OpenJDK 17

```
dnf search jdk | egrep -- '-17'

dnf install java-17-openjdk java-17-openjdk-devel
```

### 安装 Oracle JDK 17

```
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm

rpm -Uvh jdk-17_linux-x64_bin.rpm
```
