### GitHub fork 仓库然后私有化

### 1. clone
```bash
git clone --bare https://github.com/ant-design/ant-design-pro.git
```

### 2. 创建私有仓库

名字就叫 `admin`


### 3. 创建 Access Token

`Profile` -> `Settings` -> `Developer settings` ->` Personal access tokens` -> `Fine-grained tokens` -> `Generate new token`

需要授予对 **新私有仓库** `admin` 的 **所有操作权限**

创建完成后，拷贝 Access Token

### 4. push 到新仓库

```bash
cd ant-design-pro.git

git push --mirror https://totemtec:YOUR_ACCESS_TOKEN@github.com/totemtec/admin.git
```