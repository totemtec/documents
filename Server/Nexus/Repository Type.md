# 仓库类型

- proxy 代理仓库
  - 无法上传自己的库
- hosted 托管仓库
  - 私有仓库
- group 仓库组，使用仓库直接连接这 1 个就可以了
  - 包含多个仓库
  - 仓库组里的顺序应该是
     - 私有仓库，release 优先级高于 snapshot
  - 代理仓库
  - 源仓库