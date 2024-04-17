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
sudo adduser current_user libvirt
sudo adduser current_user kvm

# 查看状态
systemctl status libvirtd


```

### 准备
修改配置

vi /etc/netplan/01-network-manager-all.yaml

文件内容如下：
```yaml
network:
  version: 2
  renderer: NetworkManager
```

修改为：
```yaml
network:
  version: 2
  renderer: NetworkManager

  ethernets:
    enp3s0:
      dhcp4: true
  bridges:
    br4:
      dhcp4: yes
      interfaces:
        - enp3s0
```

测试
```
sudo netplan try
```

估计时间比较久，可能会断网

# 创建新网桥br0

vi kvm-hostbridge.xml

```xml
<network>
  <name>hostbridge</name>
  <forward mode="bridge"/>
  <bridge name="br0"/>
</network>
```

```bash
virsh net-define /path/to/my/kvm-hostbridge.xml
virsh net-start hostbridge
virsh net-autostart hostbridge
```

### 打开防火墙

```
sudo iptables -A FORWARD -p all -i br0 -j ACCEPT
```


### 有用的命令

```
virsh net-list
virsh net-info hostbridge
virsh net-dhcp-leases hostbridge
sudo brctl show br0
```

### 虚拟机内 Rocky9 网卡配置

位于目录此目录下：

vi /etc/NetworkManager/system-connections/
```
[ipv4]
# use DHCP
#method=auto

method=manual
address1=192.168.1.10/24,192.168.1.1
dns=114.114.114.114
```