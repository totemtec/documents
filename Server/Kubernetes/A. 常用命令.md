# K8s 常用命令

```bash
# 查看资源
kubectl get nodes
kubectl get pod -o wide

kubectl get svc
kubectl get deployment
kubectl get replicaset

# deployment 管理的是 replicaset， replicaset 管理的是 pod

# 创建 pod 运行 nginx
kubectl run nginx --image=nginx

kuberctl create deployment nginx-deployment --image=nginx

# 编辑一个 deployment
kubectl edit deployment nginx-deployment

# 查看 pod 日志
kubectl logs nginx-deployment-xxxxxxxxxx-xxxxxx

# 进入容器
kubectl exec -it nginx-deployment-xxxxxxxxxx-xxxxxx -- /bin/bash


kubectl -n kubernetes-dashboard get svc
```

### 创建资源

```bash
kubectl create -f nginx-deployment.yaml

# 创建或者更新
kubectl apply -f nginx-deployment.yaml
```

### 删除资源

```bash
kubectl delete -f nginx-deployment.yaml

kubectl delete deployment nginx-deployment
```


### 创建服务

```bash
kubectl create service nginx-service
kubectl expose deployment nginx-deployment

# 查看服务的详细信息
kubectl describe service nginx-service

# 删除服务
kubect delete service nginx-service