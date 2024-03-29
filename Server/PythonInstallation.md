# Python3.11 最新版 在 CentOS7.6 上的安装

安装依赖
```bash
yum install wget -y
yum -y install gcc install zlib zlib-devel bzip2-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel uuid-devel libffi libffi-devel
yum -y install epel-release
yum -y install openssl-devel openssl11 openssl11-devel
yum groupinstall -y "Development Tools" --skip-broken
```

设置环境变量
```bash
export CFLAGS=$(pkg-config --cflags openssl11)
export LDFLAGS=$(pkg-config --libs openssl11)
```

下载源代码
```bash
cd /usr/src
wget https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz
tar xzf Python-3.11.5.tgz
```

编译安装
```bash
cd Python-3.11.5
./configure --enable-optimizations
make
make install
```

检查安装结果
```bash
python3 --version
```

安装错误
```
The necessary bits to build these optional modules were not found:
_tkinter
To find the necessary bits, look in setup.py in detect_modules() for the module's name.
```

tkinter是一个图形界面库，一般用不上，具体安装方法可以见下面连接，没测试过

https://tkdocs.com/tutorial/install.html#installlinux
