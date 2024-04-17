# 网络管理

### 网卡信息

```bash
ip addr
```

### Rocky9 网卡配置

位于目录此目录下：

```bash
cd /etc/NetworkManager/system-connections/ && ll
ll
```

网络设备名.nmconnection

```bash
[ipv4]
# use DHCP
#method=auto

method=manual
address1=192.168.1.10/24,192.168.1.1
dns=114.114.114.114
```

### 桥接网络

```bash
sudo brctl show
```

### nmcli

是一个广泛使用的网络管理命令行工具，用于管理 NetworkManager（创建、显示、编辑、删除、激活和停用网络连接）并显示网络设备状态


### nm-connection-editor

nm-connection-editor 是一个用于管理 NetworkManager 连接配置的图形化工具。NetworkManager 是一个在 Linux 操作系统上管理网络连接的守护进程。nm-connection-editor 提供了一个直观的界面，让用户可以轻松地配置各种网络连接选项，包括以太网、Wi-Fi、VPN 等。

### 网桥管理工具 bridge-utils

```bash
sudo brctl show br0
```

### ip

ip命令 用来显示或操纵Linux主机的路由、网络设备、策略路由和隧道

##### OPTIONS：选项。

- -s：显示出该设备的统计数据(statistics)，例如总接受封包数等；

##### OBJECT：动作对象，就是是可以针对哪些网络设备对象进行动作。

- link：关于设备 (device) 的相关设定，包括 MTU，MAC 地址等。
- addr/address：关于额外的 IP 设定，例如多 IP 的实现等。
- route ：与路由有关的相关设定。

例子：

```bash
ip link list
ip -s link list

ip link show                    # 显示网络接口信息
ip link show type bridge        # 查看桥接设备信息
ip link set eth0 up             # 开启网卡
ip link set eth0 down            # 关闭网卡

ip addr show     # 显示网卡IP信息
ip route show   # 显示系统路由
ip route list                 # 查看路由信息
ip route del default          # 删除默认路由
ip route delete 192.168.1.0/24 dev eth0 # 删除路由

ip neigh list     # 显示局域网邻居

ip link | grep -E '^[0-9]' | awk -F: '{print $2}'   # 获取主机所有网络接口
```

### virsh

virsh 是 KVM 中 libvert 的命令行交互工具

```bash
virsh net-list --all
virsh net-info hostbridge
virsh net-dhcp-leases hostbridge
virsh net-edit default
```
