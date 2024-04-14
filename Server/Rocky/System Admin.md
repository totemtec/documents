# Rocky 9 系统管理

### 设置时区

```
timedatectl set-timezone Asia/Shanghai
```

### 更改主机名

```
hostnamectl set-hostname YOUR_HOST_NAME
```


### vi 无法输入中文

```
vim  ~/.bashrc


export LC_ALL=C.UTF-8
export LANG=C.UTF-8

source ~/.bashrc

```

消除上述警告的方法：

```
vi /etc/environment

添加下面2行
LANG=en_US.utf-8
LC_ALL=en_US.utf-8
```
