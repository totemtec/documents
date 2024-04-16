# CentOS8 安装 Python 3.6

查看已安装的版本

```bash
python --version
python2 --version
python3 --version

which python
which python2
which python3

pip --version
pip2 --version
pip3 --version

which pip
which pip2
which pip3
```

系统已经自带了 `python2` 和 `python3`，`python` 命令指向了 `python2`

没有 `pip` 和 `pip2`，只有 `pip3`

### 方式一：直接设置别名

```bash
vi ~/.bashrc

alias python='python3'
alias pip='pip3'
```

### 方式二：软连接

先删掉已有软连接，然后创建新的软连接

```bash
rm -f /usr/bin/python
ln -s /usr/bin/python3 /usr/bin/python
ln -s /usr/bin/pip3 /usr/bin/pip
```

检查安装结果

```bash
python --version
```

# 还需要修改 yum 的脚本，否则会报错

```
  File "/usr/bin/yum", line 30
    except KeyboardInterrupt, e:
                            ^
SyntaxError: invalid syntax
```

vi /usr/bin/yum
```
#!/usr/bin/python
替换为
#!/usr/bin/python2

```

vi /usr/libexec/urlgrabber-ext-down
```
#! /usr/bin/python
替换为
#! /usr/bin/python2
```