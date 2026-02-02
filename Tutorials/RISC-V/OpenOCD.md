# OpenOCD 安装

### 安装依赖库

sudo apt-get update
sudo apt install libtool
sudo apt-get install pkg-config libjim-dev

### 克隆代码

git clone --recurse-submodules https://github.com/openocd-org/openocd.git

cd openocd

### 配置

./bootstrap
./configure --enable-remote-bitbang

### 构建和安装

make
sudo make install


### Spike 调试运行

```sh
# OpenOCD 使用 remote-bitbang 来连接
spike --isa=RV32IMAFDC --rbb-port=9824 --halted hello.elf
```

### OpenOCD 连接 spike 的配置

pike.cfg

```
adapter driver remote_bitbang
remote_bitbang host localhost
remote_bitbang port 9824

set _CHIPNAME riscv
jtag newtap $_CHIPNAME cpu -irlen 5 

set _TARGETNAME $_CHIPNAME.cpu
target create $_TARGETNAME riscv -chain-position $_TARGETNAME

bindto 0.0.0.0
gdb_report_data_abort enable

init
reset halt
```

### OpenOCD 连接 Spike

openocd -f spike.cfg


