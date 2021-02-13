# SSH使用代理连接服务器

> 参考文档：https://kanda.me/2019/07/01/ssh-over-http-or-socks/

## 直接配置

如何让你的ssh链接使用socks代理呢, 我们可以使用nc命令, 使用ssh的ProxyCommand配合nc可以让ssh通过你设置的代理访问服务器

```bash
$ ssh -o ProxyCommand="nc -X 5 -x 127.0.0.1:1080 %h %p" root@server
```

其中使用ProxyCommand命令, 带上具体内容nc -X 5 -x 127.0.0.1:1080 %h %p, 127.0.0.1:1080是你的代理实际地址和端口 最后边的root@server是你需要登录的服务器和用户名

nc命令的常用参数:

-X是指定代理协议
* 4是socks4协议
* 5是socks5协议

-x是指定代理服务器和端口[代理服务器:端口]
* 默认socks使用1080
* HTTPS使用3128

## 使用别名

使用alias方式也可以:

打开你的.bashrc或者.zshrc配置alias
```bash
$ vim ~/.bashrc

alias connserver=ssh -o ProxyCommand="nc -X 5 -x 127.0.0.1:1080 %h %p" root@server
```

保存退出后输入一下:
```bash
$ source ~/.bashrc
```

下次我们访问服务器的时候直接输入connserver就行
```bash
$ connserver
```

## 配置方式

我们也可以使用ssh的config配置

编辑ssh的配置文件, 没有这个文件的话, 自己创建一下:
```bash
$ vim ~/.ssh/config
```

然后写入一些命令
```bash
Host *
    ProxyCommand nc -X 5 -x 127.0.0.1:1080 %h %p
```
下次使用ssh的时候就不需要配置代理了
