# Linux 64 位上安装使用32位RISC-V模拟器Spike


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

### 模拟器调试模式运行

这种情况下 Spike 会占用一整个核心跑到 100%，风扇就呼呼的了，所以限制一下 Spike 的CPU 占用

```sh
sudo systemd-run --scope -p CPUQuota=10% ./run.sh debug
```

