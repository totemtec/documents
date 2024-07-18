# 重启某个 Node

```bash
# 获取节点信息
kubectl get nodes

# 取消订阅节点
kubectl describe node 192.168.1.157

# 登录到节点
ssh root@192.168.1.157

# 重启。on node
systemctl restart kubelet

# 重新获取节点状态
kubectl get nodes
```
