### CentOS 7 在 VMWare 虚拟机装完不联网问题

```bash
cd /etc/sysconfig/network-scripts/
vi ifcfg-ens33
```

修改最后 1 行为 yes ，并添加 2 行

```
ONBOOT=yes
IPV6_PRIVACY=no
ETHTOOL_OPTS="autoneg on"
```

```bash
systemctl service network restart
```


### CentOS 7 虚拟机 SSH 特别慢

```bash
vi /etc/ssh/sshd_config
```

修改为
```
UseDNS no
```

```bash
systemctl restart sshd
```


### CentOS 7.9 域名解析太慢

修改网卡配置文件，禁止自动获取 DNS

```bash
vi /etc/sysconfig/network-scripts/ifcfg-eth0
```

增加 1 行

```shell
PEERDNS="no"
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