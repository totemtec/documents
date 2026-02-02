# RISC-V GNU Compiler Toolchain 

```sh
sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip python3-tomli libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev
```

```sh
export RISCV=/opt/riscv
export PATH=$PATH:$RISCV/bin
```

```sh
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain

cd riscv-gnu-toolchain
mkdir build
cd build
../configure --prefix=$RISCV
make
sudo make install
```

## 设置 RISCV 目录和环境变量PATH
