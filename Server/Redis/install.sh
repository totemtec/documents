#!/bin/sh

# https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/install-redis-on-linux/



sudo cat > /etc/yum.repos.d/redis.repo <<EOF

[Redis]
name=Redis
baseurl=http://packages.redis.io/rpm/rhel9
enabled=1
gpgcheck=1

EOF

curl -fsSL https://packages.redis.io/gpg > /tmp/redis.key
sudo rpm --import /tmp/redis.key
sudo dnf install -y epel-release
sudo dnf install -y redis

systemctl enable redis

systemctl start redis

if [[ $? -eq 0 ]]; then
    echo "Redis install succeeded"
else
    echo "Redis install failed"
fi