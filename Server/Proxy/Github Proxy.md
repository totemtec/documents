# Git 代理

### Git 全局代理

```bash
git config --global http.proxy http://172.28.100.33:15732
git config --global https.proxy http://172.28.100.33:15732
```

### GitHub 代理

```bash
git config --global http.https://github.com.proxy http://172.28.100.33:15732
git config --global https.https://github.com.proxy http://172.28.100.33:15732
```

### 取消代理

```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 查看已有的配置

```bash
git config --global -l
```