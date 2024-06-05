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

