# Windows 10 系统上使用 NVM 上管理多个 NodeJS 版本

1. 下载NVM最新版本

https://github.com/coreybutler/nvm-windows/releases

2. 以管理员身份运行安装程序，安装NVM

3. 运行nvm时，要求以管理员身份运行 “Terminal 命令提示符” 或者 “Windows PowerShell”

4. 管理命令
~~~
nvm install 版本号 
nvm current 
nvm use 版本号 
~~~
更多命令请参考官方文档 

**有时候nodejs和electron有 ia32 和 x64 架构的区别**
~~~
nvm arch [32] 
nvm install 版本号 [32] 
nvm current 
nvm use 版本号 [32] 
~~~

查看当前nodejs使用的架构
~~~
node -p "process.arch"
~~~
