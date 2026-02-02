# Linux 64 位上安装使用32位RISC-V模拟器Spike

## riscv-gnu-toolchain

```sh
sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip python3-tomli libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev
```

```sh
export RISCV=/opt/RISCV
export PATH=$PATH:$RISCV/bin
```

```sh
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain

cd riscv-gnu-toolchain
mkdir build
cd build
../configure --prefix=$RISCV
make
```

## 设置 RISCV 目录和环境变量PATH

# riscv-pk


```sh
git clone https://github.com/riscv/riscv-pk

cd riscv-pk

mkdir build
cd build
../configure --prefix=$RISCV --host=riscv32-unknown-elf
make
make install

```

# riscv-isa-sim ( Spike )

```sh
git clone https://github.com/riscv/riscv-isa-sim

cd riscv-isa-sim
mkdir build && cd build
../configure --prefix=$RISCV
make
make install
```

### 编译

```sh
riscv32-unknown-elf-gcc -o hello.elf main.c
```

### 模拟器运行

```sh
spike --isa=RV32IMAFDC pk hello.elf
```


