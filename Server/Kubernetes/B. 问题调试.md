# K8s 安装和调试问题

```bash
# 查看 pods
kubectl get pods --namespace=kubernetes-dashboard

# 查看 pod 日志
kubectl logs -f kubernetes-dashboard-kong-7696bb8c88-ss8sb --namespace=kubernetes-dashboard


```


### 安装 Dashboard 后 kong 启动 失败

kubernetes-dashboard-kong-7696bb8c88-ss8sb              0/1     CrashLoopBackOff

查看日志显示

socket() [::]:8443 failed (97: Address family not supported by protocol

这是 Nginx 配置了 ipv6 的端口监听，但是我们的 节点禁用了 ipv6，需要启动 IPV6


### DNS 问题

看这篇文档就够了

https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/dns-debugging-resolution/


### 镜像拉取失败，pod 状态为 ImagePullBackOff

需要重新拉取镜像

```bash
# 我也不知道是不是用的最新版，反正这样可以了
docker pull coredns/coredns
```