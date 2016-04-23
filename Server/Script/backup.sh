#!/bin/sh

#### 每天凌晨4点执行此脚本进行备份，Cron如下设置
#### 0 4 * * * /data/backup/backup.sh


# 项目名称，备份的文件也会以此为前缀
PROJECT_NAME="cestlavie"

# 数据库备份需要用到的参数
DB_HOST="182.92.111.111"
DB_NAME="cestlavie"
DB_USER="cestlavie"
DB_PASSWORD="XXXXXXXX"

# 需要打包备份的目录

# CKFinder后台编辑人员上传目录
USER_FILES_PATH="/data/www/ckfinder/userfiles"

# Java程序上传目录
UPLOAD_PATH="/data/www/upload"

# Java程序配置目录
CONFIG_PATH="/data/cestlavie/tomcat8/bin/cestlavie"

# 打包后把文件放在下面目录里
BACKUP_FOLDER="/data/cestlavie/backup"

##########################################################################################
###############################   以上是全部配置项    ######################################
##########################################################################################

now="$(date +'%Y%m%d_%H%M')"

user_files_archive=${PROJECT_NAME}_"user_files_${now}".tar.gz
upload_archive=${PROJECT_NAME}_"upload_${now}".tar.gz
config_archive=${PROJECT_NAME}_"config_${now}".tar.gz
database_archive=${PROJECT_NAME}_"database_${now}".tar.gz

# 备份工作日志文件按月保存
logfile=${BACKUP_FOLDER}/log_"$(date +'%Y%m')".txt

echo start backup "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"

# 备份几个用户文件目录
echo start ${user_files_archive} at "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"
tar zcvf ${BACKUP_FOLDER}/${user_files_archive}  ${USER_FILES_PATH}
echo end ${user_files_archive} at "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"

echo start ${upload_archive} at "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"
tar zcvf ${BACKUP_FOLDER}/${upload_archive}  ${UPLOAD_PATH}
echo end ${upload_archive} at "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"

echo start ${config_archive} at "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"
tar zcvf ${BACKUP_FOLDER}/${config_archive}  ${CONFIG_PATH}
echo end ${config_archive} at "$(date +'%Y-%m-%d_%H:%M:%S')" >> "$logfile"


# 备份MySQL数据库文件

export MYSQL_PWD=${DB_PASSWORD}

echo "mysqldump started at $(date +'%Y-%m-%d %H:%M:%S')" >> "$logfile"

mysqldump --host=${DB_HOST} --user=${DB_USER} --default-character-set=utf8 ${DB_NAME} | gzip > "$database_archive"

echo "mysqldump finished at $(date +'%Y-%m-%d %H:%M:%S')" >> "$logfile"

chown root "$database_archive"
chown root "$logfile"
echo "file permission changed" >> "$logfile"
find "${BACKUP_FOLDER}" -name "${PROJECT_NAME}_*" -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$logfile"
echo "operation finished at $(date +'%Y-%m-%d %H:%M:%S')" >> "$logfile"
echo "*****************" >> "$logfile"
exit 0