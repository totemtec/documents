### CentOS 7 在 VMWare 虚拟机装完不联网问题

```bash
vi /etc/sysconfig/network-scripts/ifcfg-ens33
 
# 修改最后 1 行为 yes
ONBOOT=yes

# 重启网络服务
systemctl service network restart
```


### CentOS 7.9 域名解析太慢

参考文档

> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/manually-configuring-the-etc-resolv-conf-file_configuring-and-managing-networking#disabling-dns-processing-in-the-networkmanager-configuration_manually-configuring-the-etc-resolv-conf-file

修改网卡配置文件，禁止自动获取 DNS

```bash
cat >>/etc/NetworkManager/conf.d/90-dns-none.conf <<EOF
[main]
dns=none
EOF
```

```bash
vi /etc/NetworkManager/NetworkManager.conf

[main]
dns=none
rc-manager=unmanaged
```

手动管理 DNS

```bash
vi /etc/resolv.conf
```

内容如下

```shell
nameserver 180.76.76.76
nameserver 119.29.29.29
nameserver 223.6.6.6
```

# 记得要重启 NetworkManager

```bash
systemctl restart NetworkManager
```