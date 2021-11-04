# Windows 10 系统管理多个 Python 版本

## 方式一：环境内变量修改
右击 我的电脑 - 属性 - 高级系统设置 - 环境变量 - 编辑
PATH 里放在前面的是优先使用的版本，包括2个路径
C:\Python27\;
C:\Python27\Scripts\

需要重启Terminal 命令行提示符
好处是修改完以后，pip和运行脚本都没问题

1. 手动 为环境变量PATH添加一段 %PYTHON_HOME%
2. 使用脚本为PYTHON_HOME设置新值
   参考：setpython2.7.bat


## 方式二：官方 Python Launcher for Windows

py -2.7
py -3.10

py -2  script.py
py -3.10  script.py

缺点是在Windows下无法执行 python script.py


## 方式三：使用 pyenv 管理 python 版本

官方（不支持Windows）：
https://github.com/pyenv/pyenv

Windows版本：
https://github.com/pyenv-win/pyenv-win#installation


