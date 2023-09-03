# Python 最新版 在 CentOS 上的安装

```
yum install wget -y
yum install gcc yum-utils zlib-devel python-tools cmake git pkgconfig -y --skip-broken
yum groupinstall -y "Development Tools" --skip-broken
cd /usr/src
```

```
wget https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz
tar xzf Python-3.11.5.tgz
cd Python-3.11.5
./configure
make
make install
```

```
python3 --version
```
