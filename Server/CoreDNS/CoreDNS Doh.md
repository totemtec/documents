# 使用 CoreDNS 配置 DoH（DNS over HTTPS） 

Corefile 如下所示

```
https://. {

    tls /etc/nginx/ssl/dns.totemtec.com.pem /etc/nginx/ssl/dns.totemtec.com.key {
        client_auth nocert
    }


    hosts {
        192.168.11.208 test.local
        192.168.11.208 test.aaa.com
        fallthrough
    }

    forward . 114.114.114.114
    log
    errors
}
```

测试可以使用 Chrome 设置里面使用安全 DNS，自定义

```
https://dns.totemtec.com/dns-query
```

也可以使用脚本 test_doh.py