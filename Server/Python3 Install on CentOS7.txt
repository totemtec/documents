安装步骤

### 保持系统原有版本Python2.x 不变的情况下使用 Python 3.x，使用 virtualenv 构建合适版本的虚拟环境

# 安装Python3.6

1. 编译环境准备

准备一下编译环境，防止出现安装错误

> # yum groupinstall 'Development Tools'
> # yum install zlib-devel bzip2-devel openssl-devel ncurese-devel
 
 
2. 下载python3.6代码包

这里选择下载最近版本的Python3.6.2

> # wget https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tar.xz

3. 编译

> # tar Jxvf Python-3.6.2.tar.xz
> # cd Python-3.6.2
> # ./configure --prefix=/usr/local/python3 --enable-optimizations
> # make && make install

# 使用系统的python2.7搭建虚拟环境

1. 检查版本
> # python --version
> 2.7
> # pip --version
> 9.0

CentOS7.3默认安装有Python2.7和pip9.0

2. 安装虚拟工具
> # pip install virtualenv
> # virtualenv --version

3. 创建文件夹构建虚拟环境
> # mkdir /workspace
> # cd /workspace
> # virtualenv -p /usr/local/python3/bin/python3 venv

启动虚拟环境
> # source venv/bin/activate

可以查看虚拟环境中的Python和pip版本
> # python -V
> # pip -V

退出虚拟环境
> # deactivate
