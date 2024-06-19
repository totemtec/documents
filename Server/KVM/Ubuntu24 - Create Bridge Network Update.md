# KVM 使用网桥

Ubuntu22

### 目标

1. 虚拟机使用 KVM
2. 虚拟机和 Host 使用同样的网段，并且能用 DHCP
3. 虚拟机能访问实体机，实体机也能访问虚拟机，看起来虚拟机就是个实体机


参考文档

> https://www.cyberciti.biz/faq/how-to-add-network-bridge-with-nmcli-networkmanager-on-linux/

### KVM 安装

略


### 查看现有连接和设备

`nmcli`: 是一个命令行工具，用于管理 NetworkManager 的连接

```bash
nmcli con show
nmcli connection show --active
```

显示如下信息

```bash
NAME                    UUID                                  TYPE      DEVICE
netplan-enp0s31f6       d4735e4b-9bfa-3052-b1c4-ef3302803c9a  ethernet  enp0s31f6
```

### 创建网桥 br0

```bash
nmcli con add ifname br0 type bridge con-name br0
nmcli con add type bridge-slave ifname enp0s31f6 master br0   这句里面有 DEVICE 标识
nmcli connection show
```

显示如下信息

```bash
NAME                    UUID                                  TYPE      DEVICE
netplan-enp0s31f6       d4735e4b-9bfa-3052-b1c4-ef3302803c9a  ethernet  enp0s31f6
br0                     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  bridge    br0
bridge-slave-enp0s31f6  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ethernet  --
```

### Disable STP 

bridge.stp no: 是修改的参数部分，其中 bridge.stp 表示桥接的 Spanning Tree 协议设置，no 表示禁用 Spanning Tree 协议。

```bash
sudo nmcli con modify br0 bridge.stp no
nmcli con show
nmcli -f bridge con show br0
```

显示如下信息

```bash
bridge.mac-address:                     --
bridge.stp:                             no
bridge.priority:                        32768
bridge.forward-delay:                   15
bridge.hello-time:                      2
bridge.max-age:                         20
bridge.ageing-time:                     300
bridge.multicast-snooping:              yes
```

### 关掉网卡的连接，改用网桥连接

注意：第一句命令就会关掉现有网络。直接操作电脑才可以，远程就连不上了

```bash
nmcli con down "netplan-enp0s31f6"  这里是连接名称
nmcli con up br0
nmcli con show
```

使用下面命令可以查看结果

```bash
ip a s
ip a s br0
```

### KVM 配置网桥 br0

```bash
cat /tmp/br0.xml       随便放哪吧，只要别被乱改了就行
```

配置如下：

```xml
<network>
  <name>br0</name>
  <forward mode="bridge"/>
  <bridge name="br0" />
</network>
```


### 虚拟机管理网络

```bash
virsh net-define /tmp/br0.xml
virsh net-start br0
virsh net-autostart br0
virsh net-list --all
```

输出如下

```bash
 Name                 State      Autostart     Persistent
----------------------------------------------------------
 br0                  active     yes           yes
 default              inactive   no            yes
```

### 成功

这个时候创建虚拟机或者修改虚拟机网络配置，下拉选择网络资源，就可以看到一个 Virtual network 'br0': Bridge network
