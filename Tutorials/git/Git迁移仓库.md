### 1. Git迁移仓库

```bash
# 1. 从 **老服务器** 上克隆到本地
git clone --bare http://172.18.204.7:9980/majianglin/verilog.git

# 2. 进入项目目录
cd verilog.git

# 3. 在 新的gitlab服务器 上创建项目，不用做初始化

# 4. 推送到 **新服务器** 上
git push --mirror  http://172.18.20.81:9980/majianglin/verilog.git

# 5. 从 **新服务器** 上克隆下来，作为工作区使用
git clone http://172.18.20.81:9980/majianglin/verilog.git
```

### 2. 在 **新服务器** 配置本项目的 CI/CD

