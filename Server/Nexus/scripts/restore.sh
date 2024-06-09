#!/bin/bash

# 此脚本运行在 81 上

# 将 停止服务 命令写入 容器目录

cat >> ~/nexus/stop.sh <<EOF
#!/bin/bash
/opt/sonatype/nexus/bin/nexus stop

sleep 120

kill -9 `pgrep -f keyword`

sleep 5

exit
EOF

# 执行停止命令

docker exec -it -u nexus nexus /nexus-data/stop.sh

exit

# 将 恢复文件脚本 写入容器目录
cat >> ~/nexus/restore.sh <<EOF
#!/bin/bash

cd /nexus-data
rm -rf keystores blobs
tar -xzf archive.tar.gz
mv -f BackUp/* restore-from-backup/
rm -rf BackUp

exit
EOF

# 执行恢复命令

docker exec -it -u root nexus /nexus-data/restore.sh

exit


# 重新启动 nexus

docker exec -it -u nexus nexus /bin/bash -c "/opt/sonatype/nexus/bin/nexus start &"

exit
