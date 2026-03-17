# RISCV GNU ToolChain 编译

### Ubuntu 环境准备

```sh
$ sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip python3-tomli libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev libncurses-dev
```

### 克隆

```sh
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
```

### 编译

```sh
cd gnu-toolchain
mkdir build
cd build

# 使用 multilib
../configure --prefix=/opt/riscv  --enable-multilib --with-multilib-generator="rv32e-ilp32e--;rv32ea-ilp32e--;rv32em-ilp32e--;rv32eac-ilp32e--;rv32emac-ilp32e--;rv32i-ilp32--;rv32if-ilp32f--;rv32ifd-ilp32d--;rv32ia-ilp32--;rv32iaf-ilp32f--;rv32imaf-ilp32f--;rv32iafd-ilp32d--;rv32im-ilp32--;rv32imf-ilp32f--;rv32imfc-ilp32f--;rv32imfd-ilp32d--;rv32iac-ilp32--;rv32imac-ilp32--;rv32imafc-ilp32f--;rv32imafdc-ilp32d--;rv64i-lp64--;rv64if-lp64f--;rv64ifd-lp64d--;rv64ia-lp64--;rv64iaf-lp64f--;rv64imaf-lp64f--;rv64iafd-lp64d--;rv64im-lp64--;rv64imf-lp64f--;rv64imfc-lp64f--;rv64imfd-lp64d--;rv64iac-lp64--;rv64imac-lp64--;rv64imafc-lp64f--;rv64imafdc-lp64d--;"

make
```


### 编译指定的版本

```sh
# 回退主仓库到某个tag
git checkout 2025.12.27

# 回退子模块
git submodule update --init --recursive

```

##### 子模块回退问题

error: Server does not allow request for unadvertised object 899e1510216ed1e17af7b21751b6caa38fbfce4d
fatal: Fetched in submodule path 'dejagnu', but it did not contain 899e1510216ed1e17af7b21751b6caa38fbfce4d. Direct fetching of that commit failed.

> 原因
> 子模块是一个 shallow clone（浅克隆），没有完整历史，导致找不到老 commit

解决办法

```sh
cd dejagnu
git fetch --all

# 查看这个 commit 在不在
git show 899e1510216ed1e17af7b21751b6caa38fbfce4d

# 完整历史重新 fetch
git fetch --unshallow

git checkout 899e1510216ed1e17af7b21751b6caa38fbfce4d

cd ..
git submodule update --init --recursive

```

