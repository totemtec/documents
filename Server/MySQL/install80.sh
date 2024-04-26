#!/bin/sh

# https://dev.mysql.com/doc/refman/8.3/en/linux-installation-yum-repo.html

# 可以在 https://dev.mysql.com/downloads/repo/yum/ 找到下载地址

############################################################################
###
###
###        重新安装之前需要彻底删除数据，否则不会重新生成密码
###
###
### sudo dnf remove -y mysql-community-server && sudo rm -rf /var/lib/mysql
###
###
############################################################################

sudo wget https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm

sudo dnf localinstall -y mysql80-community-release-el9-5.noarch.rpm

sudo dnf install -y mysql-community-server

sudo systemctl enable mysqld

sudo systemctl start mysqld

if [[ $? -eq 0 ]]; then
    echo "MySQL 8 install succeeded, start mysql_secure_installation..."
else
    echo "MySQL 8 install failed"
fi

#!/bin/sh

# 获取临时密码

TEMP_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log |tail -1 |awk '{split($0,a,": "); print a[2]}')

echo "MySQL root temporary password: $TEMP_PASSWORD"

echo $TEMP_PASSWORD > mysql_root_temp_password.txt

# 设置新的密码
ROOT_PASSWORD="Abcd1234$"

mysql -u root --password="${TEMP_PASSWORD}" --connect-expired-password <<EOF
SET PASSWORD FOR root@localhost = '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "MySQL root password changed, ROOT_PASSWORD=${ROOT_PASSWORD}"

# 安装安全脚本
mysql_secure_installation -u root --password="${ROOT_PASSWORD}" --use-default

# 连接测试
mysql -u root -p${ROOT_PASSWORD} -e "SELECT 1+1";

