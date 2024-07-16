# Swap 操作

参考文档

> https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-centos-7

### 检查系统 Swap 信息

方法 1 ：

```bash
# 命令
swapon -s

# 输出信息，如果没有输出信息，则说明没有 Swap
Filename                                Type            Size    Used    Priority
/dev/dm-1                               partition       6291452 0       -2
```


方法 1 ：

```bash
# 命令
free -m

# 输出信息
              total        used        free      shared  buff/cache   available
Mem:           3788         231        1412          40        2144        3255
Swap:          6143           0        6143
```


### 禁用 Swap

查看 Swap 状态和标识

```bash
# 查看 Swap 分区状态，如果 used 是 0，就可以安全地禁用它
free -h

# 确定 Swap 分区标识，TYPE="swap"
blkid

# 也可以用下面命令查找 [SWAP]
lsblk
```

临时禁用 Swap，重启失效

```bash
# 禁用一个 Swap 分区
swapoff /dev/mapper/centos-swap

# 禁用全部 Swap
swapoff -a

# 确认禁用状态
free -h

              total        used        free      shared  buff/cache   available
Mem:           3.7G        228M        1.4G         40M        2.1G        3.2G
Swap:            0B          0B          0B
```

永久禁用 Swap

```bash
# 永久禁用，注释掉其中 swap 分区的一行
vi /etc/fstab

# 重启生效
reboot
```

