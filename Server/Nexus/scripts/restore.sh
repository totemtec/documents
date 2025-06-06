#!/bin/bash

# 此脚本运行在 81 上

# 停止 nexus 服务

docker exec -d -u nexus nexus /bin/bash -c "kill -9 \`pgrep -f nexus\`"

sleep 200

echo "nexus killed"

# 将备份文件恢复

docker exec -it -u root nexus /bin/bash -c "cd /nexus-data && rm -rf keystores/node blobs restore-from-backup/* cache/* db/component db/config db/security && tar -xzf archive.tar.gz && mv -f BackUp/* restore-from-backup/ && exit"

echo "restore files write finished"

sleep 30

# 重新启动 nexus 服务

docker exec -d -u nexus nexus /bin/bash -c "exec /opt/sonatype/nexus/bin/nexus run"

echo "restart nexus"

sleep 30

echo "you can using nexus service 2 minites later."

# 5分钟后清除备份文件

docker exec -d -u root nexus /bin/bash -c "sleep 300; rm -rf BackUp archive.tar.gz; rm -rf /nexus-data/restore-from-backup/*.bak"

echo "clean will execute after 5 minutes"

sleep 30

echo "Finish."