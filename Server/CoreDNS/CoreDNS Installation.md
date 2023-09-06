# CoreDNS 安装和配置

 https://coredns.io/

 ## 安装

 文档 https://coredns.io/manual/toc/#installation

#### 下载解压

先找安装包的下载地址 https://github.com/coredns/coredns/releases

```bash
wget https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_amd64.tgz
tar xvf coredns_1.11.1_linux_amd64.tgz
```

#### 启动 CoreDNS

```bash
./coredns
```

不做任何配置的情况下，默认加载 whoami 和 log 插件，监听 53 端口

查看帮助
```
./coredns --help
```

查看插件列表
```
./coredns -plugins
```

编辑配置文件 Corefile

``` bash
# vi Corefile

.:1053 {
    forward . 114.114.114.114 223.5.5.5
    log
    errors
    whoami
}

```

这个配置文件的意思是监听 1053 端口，对所有域的请求都 forward 到 114DNS 进行解析，并且开启 whoami 插件，记录正常的日志和错误的日志。



## systemd 管理
``` bash
$ vi /usr/lib/systemd/system/coredns.service


[Unit]
Description=CoreDNS
Documentation=https://coredns.io/manual/toc/
After=network.target

[Service]
# Type设置为notify时，服务会不断重启
# 关于type的设置，可以参考https://www.freedesktop.org/software/systemd/man/systemd.service.html#Options
Type=simple
User=root
# 指定运行端口和读取的配置文件
ExecStart=/home/coredns/coredns -conf /home/coredns/Corefile
Restart=on-failure

[Install]
WantedBy=multi-user.target
```


```
$ systemctl daemon-reload
$ systemctl enable coredns
$ systemctl start coredns
$ systemctl status coredns
```

## coredns日志处理

coredns的日志输出并不如nginx那么完善（并不能在配置文件中指定输出的文件目录，但是可以指定日志的格式），默认情况下不论是log插件还是error插件都会把所有的相关日志输出到程序的standard output中。使用systemd来管理coredns之后，默认情况下基本就是由rsyslog和systemd-journald这两个服务来管理日志。

##### StandardOutput

较新版本的systemd是可以直接在systemd的unit文件里面配置StandardOutput和StandardError两个参数来将相关运行日志输出到指定的文件中。

因此对于centos8等较新的系统，我们的unit文件可以这样编写：

```
[Unit]
Description=CoreDNS
Documentation=https://coredns.io/manual/toc/
After=network.target
# StartLimit这两个相关参数也是centos8等systemd版本较新的系统才支持的
StartLimitBurst=1
StartLimitIntervalSec=15s

[Service]
# Type设置为notify时，服务会不断重启
Type=simple
User=root
# 指定运行端口和读取的配置文件
ExecStart=/home/coredns/coredns -dns.port=53 -conf /home/coredns/Corefile
# append类型可以在原有文件末尾继续追加内容，而file类型则是重新打开一个新文件
# 两者的区别类似于 echo >> 和 echo >
StandardOutput=append:/home/coredns/logs/coredns.log
StandardError=append:/home/coredns/logs/coredns_error.log
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

修改完成之后我们再重启服务就可以看到日志已经被重定向输出到我们指定的文件中
```bash
systemctl daemon-reload
systemctl restart coredns.service
```


##### rsyslog
对于centos7等系统而言，是不支持上面的append和file两个参数的，那么在开启了rsyslog.service服务的情况下，日志就会输出到/var/log/messages文件中，或者可以使用journalctl -u coredns命令来查看全部的日志。

如果想要将coredns的日志全部集中到一个文件进行统一管理，我们可以对负责管理systemd的日志的rsyslog服务的配置进行修改：

```
# vim /etc/rsyslog.conf
if $programname == 'coredns' then /home/coredns/logs/coredns.log
& stop

$ systemctl restart rsyslog.service
```

##### 两种方式打出来的日志稍微有些不同，对于StandardOutput这种方式输出的日志缺少了前面的时间和主机名等信息，相对而言还是修改rsyslog的方式要更加的可靠。


### 提供 DNS over HTTPS 服务

参考文档
https://github.com/coredns/coredns#examples

DNS over TLS and gRPC

``` Corefile
tls://example.org grpc://example.org {
    whoami
}
```

DNS over HTTPS
```
https://example.org {
    whoami
    tls mycert mykey
}
```