# Rye 0.32 在 Win 11 上的安装

### 打开开发者模式

- 设置
  - 系统
    - 开发人员模式，设置为 `开`

### 下载 Windows 安装包

> https://github.com/astral-sh/rye/releases/

### 运行安装

双击运行 `rye-x86_64-windows.exe`

> ** NOTE **
> Windows 已保护你的电脑，点击 **更多信息**，**仍要运行**

安装过程中会有几个问题：

直接回车用默认


### 重启 VSCode 控制台才能运行 rye

安装完成后需要重启 Terminal / VSCode


### 问题排查

- 找不到 ipykernel
  - 可以给本项目虚拟环境中安装：rye add ipykernel

