#!/bin/sh

# https://dev.mysql.com/doc/refman/8.3/en/linux-installation-yum-repo.html

# 可以在 https://dev.mysql.com/downloads/repo/yum/ 找到下载地址

sudo wget https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm

sudo dnf localinstall -y mysql80-community-release-el9-5.noarch.rpm

sudo dnf install -y mysql-community-server

sudo systemctl enable mysqld

sudo systemctl start mysqld

TEMP_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log |tail -1 |awk '{split($0,a,": "); print a[2]}')

echo "MySQL root password: $TEMP_PASSWORD"

echo $TEMP_PASSWORD > root_temp_password.txt

# 设置新的密码

TEMP_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log |tail -1 |awk '{split($0,a,": "); print a[2]}')

echo "MySQL root password: $TEMP_PASSWORD"

echo $TEMP_PASSWORD > root_temp_password.txt

# 设置新的密码
MYSQL_PWD="Abcd1234$"


mysql -u root --password="${TEMP_PASSWORD}" --connect-expired-password <<EOF
SET PASSWORD FOR root@localhost = '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mysql_secure_installation -u root --password="${ROOT_PASSWORD}" --use-default


mysql -u root -p${ROOT_PASSWORD} -e "SELECT 1+1";
