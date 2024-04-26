#!/bin/sh

sudo yum install -y yum-utils


sudo cat > /etc/yum.repos.d/nginx.repo <<EOF

[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/9/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/9/x86_64/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

EOF


sudo yum-config-manager --enable nginx-mainline

sudo yum install -y nginx

sudo systemctl enable nginx

sudo systemctl start nginx

sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

echo "Nginx install success!"

sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https 