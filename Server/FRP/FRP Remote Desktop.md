# 使用 FRP 内网穿透，访问内网电脑的远程桌面

环境 CentOS 9.3, Windows 11, FRP 0.56, WinSW 3.0 alpha 11

理论上也可以实现访问内网电脑的任何端口或服务

下载地址

> https://github.com/fatedier/frp/releases

注意版本的不同

参考文档

> https://gofrp.org/docs/

#### 中转服务器安装

```ini
# frps.toml
bindPort = 7000
```

使用端口 7000 来提供服务端接入。记得中转服务器防火墙要开这个端口

启动中转服务

`./frps -c ./frps.toml`

#### 中转服务器安装为自启动服务

```bash
vi /etc/systemd/system/frps.service
```

```ini
[Unit]
# 服务名称，可自定义
Description = frp server
After = network.target syslog.target
Wants = network.target

[Service]
Type = simple
# 启动frps的命令，需修改为您的frps的安装路径
ExecStart = /root/frp/frps -c /root/frp/frps.toml

[Install]
WantedBy = multi-user.target
```

```bash
# 启动frp
systemctl start frps
# 停止frp
systemctl stop frps
# 重启frp
systemctl restart frps
# 查看frp状态
systemctl status frps

# 设置开机启动
systemctl enable frps
```

#### Windows 桌面服务端安装

```ini
# frpc.ini
[common]
server_addr = x.x.x.x  # 中转服务器IP 
server_port = 7000     # 中转服务器接入端口

[ssh]
type = tcp             # 本机服务协议 
local_ip = 127.0.0.1   # 本机服务网址，一般不用改
local_port = 3389      # 本机服务端口，Windows 远程桌面用 3389，记得开远程桌面服务
remote_port = 6000     # 客户端连接本服务时，中转服务器使用的端口，例如：x.x.x.x:6000，记得中转服务器防火墙要开这个端口。
```

> **Warning**
> 最好限制其他 IP 访问中转服务器的 6000 端口，以保障安全。远程桌面暴露到公网上安全性不好。


启动远程桌面服务端，连接中转服务器

`./frpc -c ./frpc.ini`

#### Windows 桌面服务端安装为自启动服务

下载 WinSW

> https://github.com/winsw/winsw/releases

文件 WinSW-x64.exe 跟 frpc.exe，frpc.ini 放到同一个目录下。

增加配置文件 frpc-service.xml

```xml
<service>
    <id>frpc</id>
    <name>frpc</name>
    <description>用frp发布远程桌面服务到外网</description>
	<workingdirectory>D:\Programs\frp</workingdirectory>
    <!-- 启动可执行文件的路径 -->
    <executable>D:\Programs\frp\frpc.exe</executable>
    <arguments>-c frpc.ini</arguments>
    <log mode="roll"></log>
</service>
```

```bash
# 安装为 Windows 服务，安装完成后，可以在 services.msc 里面查看和管理服务
D:\Programs\frp> .\WinSW-x64.exe install frpc-service.xml

# 启动服务
D:\Programs\frp> .\WinSW-x64.exe start frpc-service.xml

# 停止服务
D:\Programs\frp> .\WinSW-x64.exe stop frpc-service.xml

# 卸载服务
D:\Programs\frp> .\WinSW-x64.exe uninstall frpc-service.xml
```

#### 客户端访问

使用 Windows Remote Desktop 直接连接中转服务器 x.x.x.x:6000 端口即可