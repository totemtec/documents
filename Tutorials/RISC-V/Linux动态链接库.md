# Linux 动态链接库的更换

```sh
### 查看可执行程序依赖的库
ldd ./openocd

### 看到哪个 lib not found 没有可以从别的机器上拷贝

### 设置程序的动态链接库从相对路径 ../lib 查找
patchelf --set-rpath '$ORIGIN/../lib' /opt/openocd/bin/openocd

```