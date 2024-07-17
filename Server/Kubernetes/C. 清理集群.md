# 清理删除 K8s 集群

参考文档

> https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#tear-down

```bash
# TODO: 这句是什么意思
kubectl drain <节点名称> --delete-emptydir-data --force --ignore-daemonsets

# 重置 kubeadm 安装的状态
kubeadm reset

# 重置 iptables
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

# 重置 IPVS 表
ipvsadm -C

# 移除节点
kubectl delete node <节点名称>

```


worker 节点清理

```bash
kubeadm reset --cri-socket=unix:///var/run/cri-dockerd.sock
```