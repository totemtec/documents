# 编译Chromium

## 官方编译说明
```
https://chromium.googlesource.com/chromium/src/+/HEAD/docs/android_build_instructions.md
```

## 系统要求
```
64-bit Intel 主机
16G 内存
100GB 硬盘
Ubuntu 20，不支持win和mac
git 2.25+
python 3.8+
```

```
# apt update -y
# apt install git -y
```

安装 Ubuntu 默认 Python3 版本3.8
```
# apt install python-is-python3
# apt install python3-pip -y
```


## 获取源码管理工具
```
# mkdir /work && cd /work
# git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
# export PATH="${PATH}:/work/depot_tools"
```

这里也可以把depot_tools目录加入PATH
vi ~/.bashrc
export PATH="$PATH:/work/depot_tools"

## 下拉chromium源码
```
# mkdir ~/chromium && cd ~/chromium
# fetch --nohooks android
```
源码大约50G，很大

## 切换版本
```
# cd src
# git fetch origin --tags
# git tag -l --sort=-creatordate --format='%(creatordate:short):  %(refname:short)'
# git checkout 103.0.5060.102
```

## 安装附加依赖包
```
# ./build/install-build-deps-android.sh
# gclient sync -D
```

## Run the hooks 这一步不是必须的，上面 gclient sync 自带这步
```
# gclient runhooks
```

## 编译配置

Chromium使用Ninja作为主要的构建工具，并通过GN来生成.ninja配置文件。

通过 gn args out/Default 指令，会启动系统的默认编辑器进入配置文件编辑模式，并在 out/Default 目录下初始化此版本的编译，生成 args.gn 文件，这个时候输入以下的配置参数并保存，GN 会帮我们初始化好所有的 .ninja 配置文件。

```
# gn args out/Default
```

会打开一个文本编辑器，填入下面内容，然后像vim一样保存退出，就会生成配置文件
```
# 目标操作系统
target_os = "android"
# 目标架构
target_cpu = "arm"
# 不把警告作为错误，否则有一定可能性遭遇警告转来的编译错误
treat_warnings_as_errors = false
# 编译“正式版”，而非“开发人员内部版本”，启动正式版具有的性能优化
is_official_build = true
# 编译 ffmpeg 相关模块以提供 H.264 视频解码功能
ffmpeg_branding = "Chrome"
proprietary_codecs = true
```

## 编译 Chromium
```
# autoninja -C out/Default chrome_public_apk
```
编译完成后，apk 包位于 out/Default/apks

Android 代码位于
```
src/chrome/android/java/src/
```

## 清理历史构建
```
# gn clean out/Default
```