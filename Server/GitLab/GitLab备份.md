# GitLab 备份

### 系统信息

主机：172.18.204.7 虚拟机
系统版本： CentOS 7.8
Docker 版本： 20.10.21
镜像：gitlab/v1.tar   从: gitlab/gitlab-ce 修改的，目前不知道改了什么
Gitlab版本： 15.11.3
Gitlab shell: 14.18.0
Gitlab Workhorse: v15.11.3
Gitlab KAS: v15.11.0

### Docker

启动命令

```bash
docker run -itd --shm-size=1g -p 9980:9980 -p 9922:22 -v /opt/gitlab/etc:/etc/gitlab -v /opt/gitlab/log:/var/log/gitlab -v /opt/gitlab/opt:/var/opt/gitlab --restart always --privileged=true --name gitlab gitlab/gitlab-ce:15.11.3-ce.0
```
