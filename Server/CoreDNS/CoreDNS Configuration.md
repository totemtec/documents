# CoreDNS 配置

配置文件为当前目录的 Corefile

使用井号 # 开始的是注释

环境变量的使用 {$ENV_VAR}。也可以使用 windows 脚本风格的 {%ENV_VAR%}

### 导入其他配置文件（Importing Other Files）的内容

使用 import 插件

### 可复用的代码段（Reusable Snippets）

```
# define a snippet, snip is name.
(snip) {
    prometheus
    log
    errors
}

. {
    whoami
    import snip
}
```

### 服务器块（Server Blocks）

以1个或多个 zone name 打头，花括号括起来，例如 root zone：.

```
. {
    # Plugins defined here.
}
```

指定端口

```
.:1053 {
    # Plugins defined here.
}
```

Server Block 使用相同的 zone name 和 端口 是会出错的

```
# Error Configuration

.:1054 {

}

.:1054 {

}
```

使用bind插件，绑定不同的网卡或 IP，那就可以使用相同的 zone name 和 端口

```
.:1054 {
    bind lo
    whoami
}

.:1054 {
    bind eth0
    whoami
}
```

### 指定协议（Specifying a Protocol）

当前版本的 CoreDNS 支持4种协议：DNS, DNS over TLS (DoT), DNS over HTTP/2 (DoH) and DNS over gRPC

```
dns:// for plain DNS (the default if no scheme is specified).
tls:// for DNS over TLS, see RFC 7858.
https:// for DNS over HTTPS, see RFC 8484.
grpc:// for DNS over gRPC.
```

### 插件（Plugins）

每个 Server Block 可以用多个插件串起来

也可以用插件块（Plugin Block）

```
. {
    plugin {
       # Plugin Block
    }
}
```

### 外部插件（External Plugins）

必须自己编译

### 可能的错误（Possible Errors）

health 插件只需要开启一次，而且只能用一次，但是全局生效。

```
. {
    whoami
    health
}
```

### 设置 Setups

如果不是 root 用户，可以在启动时使用 -dns.port 标志来指定端口为 1053

-conf 指定配置文件

可是使用 dig 命令来调试

```
dig -p 1053 @localhost +noall +answer <name> <type>
dig -p 1053 @'dns.totemtec.com' +noall +answer www.example.org A
```

或者使用 nslookup 查询

```
nslookup [-opt ...] host server
nslookup test.com  name-server.com
```

### 使用 file 插件组织指令   //TODO: 这里的配置有问题，跟内容不一样

外部插件 redis 可以从 Redis 数据库里加载指令

当前目录，文件名 db.example.org 的 zone file，内容如下

```
$ORIGIN example.org.
@	3600 IN	SOA sns.dns.icann.org. noc.dns.icann.org. (
				2017042745 ; serial
				7200       ; refresh (2 hours)
				3600       ; retry (1 hour)
				1209600    ; expire (2 weeks)
				3600       ; minimum (1 hour)
				)

	3600 IN NS a.iana-servers.net.
	3600 IN NS b.iana-servers.net.

www     IN A     127.0.0.1
        IN AAAA  ::1
```

最后 2 行定义了一个域名 www.example.org。有 2 个地址，127.0.0.1 和 ::1 (IPv6)

下面是在 Corefile 中使用上面的 zone file。

```
example.org {
    file db.example.org
    log
}
```
用 dig 查询一下

```
$ dig www.example.org AAAA

www.example.org.    3600    IN  AAAA    ::1
```

### 转向（Forwarding）

一个最简单的配置。可以在 Windows 中指定 DNS 服务器来测试。
```
. {
    forward . 114.114.114.114
}
```