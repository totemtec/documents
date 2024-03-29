## NodeJS 项目使用国内镜像

#### 方案一：使用 tyarn，这是 yarn 的国内版本，默认使用国内的仓库镜像

Ant Design 和 Electron 的项目很好用

安装 tyarn

```bash
npm install -g tyarn --registry=https://registry.npmmirror.com
```

其他使用方法与 yarn 完全相同。

#### 方案二：使用 pnpm，这是 npm 的国内版本，默认使用国内的仓库镜像

安装 pnpm

```bash
npm install -g pnpm --registry=https://registry.npmmirror.com
```

其他使用方法与 npm 完全相同。

> **Note**
> 不建议用 cnpm，虽然速度快，但是与 npm 兼容的不好

#### 方案三：项目配置使用国内镜像

PROJECT_HOME/.npmrc

```properties
# use taobao npm mirror
registry=https://registry.npmmirror.com

# electron download url = ELECTRON_MIRROR + ELECTRON_CUSTOM_DIR + '/' + ELECTRON_CUSTOM_FILENAME
electron_mirror="https://npmmirror.com/mirrors/electron/"

# some times you need custom dir for electron download url. because npmmirror.com using different path from npmjs.com
# electron_custom_dir="v26.1.0"

electron-builder-binaries_mirror="https://registry.npmmirror.com/-/binary/electron-builder-binaries/"
```

#### 方案四：全局配置使用国内镜像

修改镜像命令

```bash
npm config set registry https://registry.npmmirror.com
```

验证镜像修改成功

```bash
npm config get registry
```

如果返回 https://registry.npmmirror.com，说明镜像配置成功。


> **Warning**
> 这种方式对 Electron 和 electron-builder 没有配置仓库，不适合 Electron 项目

