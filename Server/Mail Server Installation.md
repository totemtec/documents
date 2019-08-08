查看postfix是否安装
# rpm -qa | grep postfix

没安装的话
# yum -y install postfix

已安装的话，停止postfix服务
# systemctl stop postfix

设置主机名
# hostnamectl set-hostname dev.totemtec.com

设置 /etc/hosts
101.200.56.164     mail.iqucang.com

修改配置文件
# vi /etc/postfix/main.cf

# line 75: uncomment and specify hostname
myhostname = mail.iqucang.com
# line 83: uncomment and specify domain name
mydomain = iqucang.com
# line 99: uncomment
myorigin = $mydomain
# line 116: change
inet_interfaces = all
# line 164: add
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
# line 264: uncomment and specify your local network
mynetworks = 127.0.0.0/8, 10.0.0.0/24
# line 419: uncomment (use Maildir)
home_mailbox = Maildir/
# line 574: add
smtpd_banner = $myhostname ESMTP
# add follows to the end
# limit an email size for 10M
message_size_limit = 10485760
# limit a mailbox for 1G
mailbox_size_limit = 1073741824
# for SMTP-Auth
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_sasl_security_options = noanonymous
smtpd_sasl_local_domain = $myhostname
smtpd_recipient_restrictions = permit_mynetworks, permit_auth_destination, permit_sasl_authenticated, reject

新增用户
# useradd admin
# passwd admin

检查postfix状态
# postfix status

测试配置

检查端口25
# netstat -plnt |grep :25
