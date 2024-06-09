#!/bin/bash

# 停止 docker nexus

docker stop --time=120 nexus

cd /opt/nexus/data

# 备份下面个目录

tar -czf archive.tar.gz BackUp keystores blobs