# 编译Chromium

## 系统要求
```
64-bit Intel 主机
16G 内存
100GB 硬盘
Ubuntu 18，不支持win和mac
git
python
```

```
# apt update -y
# apt install git -y
```

安装Ubuntu最新Python3版本3.10
```
# apt update && apt upgrade -y
# apt install software-properties-common -y
# add-apt-repository ppa:deadsnakes/ppa 然后回车
# apt install python3.10 -y
# python3.10 --version 

# update-alternatives --install /usr/bin/python python /usr/bin/python3.10 10

# apt install python3-pip -y
```

安装Ubuntu默认Python3版本3.6
```
# apt update -y
# apt install python3 -y
# python --version
# update-alternatives --install /usr/bin/python python /usr/bin/python3 10
# apt install python3-pip -y
```


## 获取源码管理工具
```
# git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
# export PATH="${PATH}:${HOME}/work/depot_tools"
```
这里也可以把depot_tools目录加入PATH
vi ~/.bashrc
export PATH="$PATH:/path/to/depot_tools"

## 下拉chromium源码
```
# mkdir ~/chromium && cd ~/chromium
# fetch --nohooks android
```