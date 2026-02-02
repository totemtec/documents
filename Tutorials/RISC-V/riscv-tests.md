# riscv-tests 使用

> https://rcore.netlify.app/trouble/riscv-test.html#下载编译

```sh
$ git clone https://github.com/riscv-software-src/riscv-tests
$ cd riscv-tests
$ git submodule update --init --recursive

修改riscv-tests/env/p/link.ld
SECTIONS {
  .=0x00000000; // 起始地址修改, 原 0x8000_0000
}


autoconf 
./configure --prefix=$RISCV/target 
make 
make install
```


### 目录说明

- `isa` 指令测试
- `benchmarks` 性能测试
- `debug` gdb测试
- `mt` Matrix 测试
- `env` 测试环境

每个目录都有自己的 Makefile 可以单独 make 或者 make isa

