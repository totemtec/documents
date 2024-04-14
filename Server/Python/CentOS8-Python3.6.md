# CentOS8 安装 Python 3.6

系统已经自带了 `python2` 和 `python3`，但是 python 命令却找不到

### 方式一：直接设置别名
```
vi ~/.bashrc

alias python='python3'
alias pip='pip3'
```

### 方式二：软连接
```
ln -s /usr/bin/python3 /usr/bin/python
ln -s /usr/bin/pip3 /usr/bin/pip
```
