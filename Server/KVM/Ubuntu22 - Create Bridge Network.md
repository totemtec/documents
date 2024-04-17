# 创建新网桥br0
$ sudo ip link add br0 type bridge

# 验证br0是否创建成功
$ sudo ip link show type bridge

# 任意路径创建文件
$ vim virsh-br0-network.xml
<network>
    <name>br0-network</name>
    <forward mode="bridge" />
    <bridge name="br0" />
</network>

# 通过virsh定义新的桥接网络
$ sudo virsh net-define virsh-br0-network.xml

# 激活新网络
$ sudo virsh net-start br0-network

# 使其自动启动
$ sudo virsh net-autostart br0-network

# 查看网络列表
$ sudo virsh net-list --all
 Name          State    Autostart   Persistent
------------------------------------------------
 br0-network   active   yes         yes
 default       active   yes         yes