# Server 

Rocky 9.3

参考文档
> https://rustdesk.com/docs/en/self-host/

### 错误排查1，无法连接

查看服务器监听端口

```bash
lsof -i 21117

COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
hbbr    1951 root    9u  IPv6  26954      0t0  TCP *:21117 (LISTEN)
```

发现监听的是 ipv6，下面彻底关掉 IPV6

```bash
sed -i '/GRUB_CMDLINE_LINUX/ s/"$/ ipv6.disable=1"/' /etc/default/grub

# 确认已经加上了
grep ipv6 /etc/default/grub

# 重新构建 grub2 配置

grub2-mkconfig -o /boot/grub2/grub.cfg

# 下面是输出
Generating grub configuration file ...
done

# 重启主机
reboot

# 检查是否生效
sysctl -a | grep -i ipv6

# 输出为空就是彻底禁用了 ipv6
```

### 错误排查2，无法连接

下面端口需要全部打开，包括 UDP 端口
TCP 21114-21119
UDP 21116

查看端口是否能连上

telnet 8.141.2.85 21115