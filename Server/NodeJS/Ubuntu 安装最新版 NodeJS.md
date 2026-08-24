# NodeJS Install on Ubuntu

# 方式一

> https://nodejs.org/en/download

```sh

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 24

# Verify the Node.js version:
node -v # Should print "v24.16.0".

# Verify npm version:
npm -v # Should print "11.13.0".

```


# 方式二 网络不好的情况下

在下载页面，下载压缩包 node-v24.16.0-linux-x64.tar.xz

https://nodejs.org/en/download

```sh
tar -xJvf node-v24.16.0-linux-x64.tar.xz

sudo mkdir /opt/nodejs
sudo mv node-v24.16.0-linux-x64 /opt/nodejs/

vi ~/.bashrc
```

```sh
export NODE_HOME="/opt/nodejs/node-v24.16.0-linux-x64"
export PATH="$NODE_HOME/bin:$PATH"
```

```sh
source ~/.bashrc

node -v
# v24.16.0

npm -v
# 11.13.0
```
