#!/bin/bash

if [ -z "$1" ]; then
    echo "请输入数据库名称"
    exit 1
fi

DB_NAME=$1

DB_USER_NAME="${DB_NAME}_user"
DB_USER_PASSWORD="$(openssl rand -base64 12)"

echo $DB_USER_NAME
echo $DB_USER_PASSWORD

cat >>mysql_database.sql <<EOL
CREATE DATABASE \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
CREATE USER \`${DB_USER_NAME}\` IDENTIFIED BY \`${DB_USER_PASSWORD}\`;
GRANT ALL ON \`${DB_NAME}\`.* TO \`${DB_USER_NAME}\`@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;


EOL

echo "Please input MySQL root password."

mysql -u root -p < mysql_database.sql

if [[ $? -eq 0 ]]; then
    echo "MySQL Database and User created success!"
    echo "Database: ${DB_NAME}, Username: ${DB_USER_NAME}, Password: ${DB_USER_PASSWORD}, "
else
    echo "MySQL failed"
fi