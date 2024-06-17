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

vi /etc/NetworkManager/NetworkManager.conf

加入一行，禁止 NetworkManager 管理 DNS
估计得完全禁止使用 NetworkManager


```
dns=none
```

```bash
systemctl daemon-reload
systemctl restart NetworkManager
```

手动管理 DNS

vi /etc/resolv.conf

```
nameserver 180.76.76.76
nameserver 119.29.29.29
nameserver 223.6.6.6
```