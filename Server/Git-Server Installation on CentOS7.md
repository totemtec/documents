参考文档：https://linuxize.com/post/how-to-setup-a-git-server/

在 CentOS 7.6 安装成功

# Step 1: 服务器安装

```bash
    [root@server ~]# sudo yum install git
    [root@server ~]# sudo useradd -r -m -U -d /home/git -s /bin/bash git
```

# Step 2: 访问权限配置

```bash
    [root@server ~]# sudo su - git
    [git@server ~]$ mkdir -p ~/.ssh && chmod 0700 ~/.ssh
    [git@server ~]$ touch ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys
```

# Step 3: 初始化仓库

```bash
    [git@server ~]$ git init --bare ~/projectname.git
```

# Step 4: 本地访问秘钥，此秘钥钥加入Step 2 authorized_keys文件中

```bash
    [user@local ~]# cat ~/.ssh/id_rsa.pub
    [user@local ~]# ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"
```

# Step 4: 本地测试

```bash
    [user@local ~]# git clone git@server_ip:/home/git/projectname.git
    [user@local ~]# touch test_file
    [user@local ~]# git add .
    [user@local ~]# git commit -m "test_file"
    [user@local ~]# git push -u origin master
```