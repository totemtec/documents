# 使用Logrotate 管理Nginx日志

按天循环并打包

Logrotate是基于CRON来运行的，其脚本是「/etc/cron.daily/logrotate」
实际运行时，Logrotate会调用配置文件「/etc/logrotate.conf」
文件中有包含 include /etc/logratate.d 文件夹
所以我们可以在「/etc/logrotate.d」目录里放置自己的配置文件。

> # vi /etc/logrotate.d/nginx

添加如下内容，内容来自包
https://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-1.12.1-1.el7.ngx.x86_64.rpm

```
/var/log/nginx/*.log {
        daily
        missingok
        rotate 52
        compress
        delaycompress
        notifempty
        create 640 nginx adm
        sharedscripts
        postrotate
                if [ -f /var/run/nginx.pid ]; then
                        kill -USR1 `cat /var/run/nginx.pid`
                fi
        endscript
}

```

如果你等不及CRON，可以通过如下命令来手动执行：

> # logrotate -f /etc/logrotate.d/nginx

当然，正式执行前最好通过Debug选项来验证一下，这对调试也很重要：

> # logrotate -d -f /etc/logrotate.d/nginx

# Logrotate的疑问

### 问题：sharedscripts的作用是什么？

大家可能注意到了，我在前面Nginx的例子里声明日志文件的时候用了星号通配符，也就是说这里可能涉及多个日志文件，比如：access.log和error.log。说到这里大家或许就明白了，sharedscripts的作用是在所有的日志文件都轮转完毕后统一执行一次脚本。如果没有配置这条指令，那么每个日志文件轮转完毕后都会执行一次脚本。

### 问题：rotate和maxage的区别是什么？

它们都是用来控制保存多少日志文件的，区别在于rotate是以个数为单位的，而maxage是以天数为单位的。如果我们是以按天来轮转日志，那么二者的差别就不大了。

### 问题：为什么生成日志的时间是凌晨四五点？

前面我们说过，Logrotate是基于CRON运行的，所以这个时间是由CRON控制的，具体可以查询CRON的配置文件「/etc/anacrontab」，可以手动改成如23:59等时间执行：

```
SHELL=/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
RANDOM_DELAY=45
START_HOURS_RANGE=3-22

#period in days   delay in minutes   job-identifier   command
1       5       cron.daily              nice run-parts /etc/cron.daily
7       25      cron.weekly             nice run-parts /etc/cron.weekly
@monthly 45     cron.monthly            nice run-parts /etc/cron.monthly
```

### 问题：如何告诉应用程序重新打开日志文件？

以Nginx为例，是通过postrotate指令发送USR1信号来通知Nginx重新打开日志文件的。但是其他的应用程序不一定遵循这样的约定，比如说MySQL是通过flush-logs来重新打开日志文件的。更有甚者，有些应用程序就压根没有提供类似的方法，此时如果想重新打开日志文件，就必须重启服务，但为了高可用性，这往往不能接受。还好Logrotate提供了一个名为copytruncate的指令，此方法采用的是先拷贝再清空的方式，整个过程中日志文件的操作句柄没有发生改变，所以不需要通知应用程序重新打开日志文件，但是需要注意的是，在拷贝和清空之间有一个时间差，所以可能会丢失部分日志数据。

BTW：MySQL本身在support-files目录已经包含了一个名为mysql-log-rotate的脚本，不过它比较简单，更详细的日志轮转详见「Rotating MySQL Slow Logs Safely」。



