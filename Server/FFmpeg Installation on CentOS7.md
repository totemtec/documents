参考文档：https://www.vultr.com/docs/how-to-install-ffmpeg-on-centos

在 CentOS 7.6 安装成功

# Step 1: Update the system

```bash
    [root@dev ~]# sudo yum install epel-release -y
    [root@dev ~]# sudo yum update -y
    [root@dev ~]# sudo shutdown -r now
```

# Step 2: Install the Nux Dextop YUM repo

```bash
    [root@dev ~]# sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
    [root@dev ~]# sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
```

# Step 3: Install FFmpeg and FFmpeg development packages

```bash
    [root@dev ~]# sudo yum install ffmpeg ffmpeg-devel -y
```

# Step 4: Test drive

```bash
    [root@dev ~]# ffmpeg
    [root@dev ~]# ffmpeg -h
```