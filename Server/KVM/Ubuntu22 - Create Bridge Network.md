# KVM 使用网桥

Ubuntu22

### 目标

1. 虚拟机使用 KVM
2. 虚拟机和 Host 使用同样的网段，并且能用 DHCP，也能手动指定 IP
3. 虚拟机能访问实体机，实体机也能访问虚拟机，看起来虚拟机就是个实体机


参考文档
> https://www.dzombak.com/blog/2024/02/Setting-up-KVM-virtual-machines-using-a-bridged-network.html

### KVM 安装

```bash
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients virtinst libguestfs-tools libosinfo-bin bridge-utils

# 查看 CPU 是否支持 KVM 虚拟化
kvm-ok

# 用户加入组，完成后需要重新登入
sudo adduser CURRENT_USER libvirt
sudo adduser CURRENT_USER kvm

# 查看状态
systemctl status libvirtd
```

### 创建新连接

```
# 创建新网桥 br0
sudo ip link add br0 type bridge
# 验证 br0 是否创建成功
sudo ip link show type bridge
```

### 准备

vi /etc/netplan/01-network-manager-all.yaml

修改配置如下：

```yaml
network:
  version: 2
  renderer: NetworkManager

  ethernets:
    enp3s0:
      dhcp4: no
  bridges:
    br0:
      dhcp4: yes
      interfaces:
        - enp3s0
```

验证配置并使配置生效

```bash
sudo netplan try
```

估计时间比较久，运行完了还需要及时按回车接受更改生效。

可能会断网，造成无法确认生效

直接生效的命令是

```bash
sudo netplan apply
```

# 创建新网桥 hostbridge

配置

vi kvm-hostbridge.xml

```xml
<network>
  <name>hostbridge</name>
  <forward mode="bridge"/>
  <bridge name="br0"/>
</network>
```

创建命令

```bash
virsh net-define /path/to/my/kvm-hostbridge.xml
virsh net-start hostbridge
virsh net-autostart hostbridge
```

### 打开防火墙

```bash
sudo iptables -A FORWARD -p all -i br0 -j ACCEPT
```

### 有用的命令

```bash
virsh net-list
virsh net-info hostbridge
virsh net-dhcp-leases hostbridge
sudo brctl show br0

# 直接文本编辑虚拟机配置
virsh edit 虚拟机名
```

重启网络

```bash
sudo systemctl restart network-manager

# 或者是
sudo systemctl restart system-networkd
```

