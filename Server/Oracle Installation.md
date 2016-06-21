参考文档：https://wiki.centos.org/HowTos/Oracle12onCentos7

在 CentOS 7.2 安装成功

# 1. 安装准备

查看系统信息
```bash
    [root@dev ~]# hostnamectl
       Static hostname: dev.totemtec.com
             Icon name: computer-desktop
               Chassis: desktop
            Machine ID: 07b008893ec44a4fbb99d9228f5136c6
               Boot ID: 337cc3dcfc5f4a559cf4561499bd172a
      Operating System: CentOS Linux 7 (Core)
           CPE OS Name: cpe:/o:centos:centos:7
                Kernel: Linux 3.10.0-327.el7.x86_64
          Architecture: x86-64
```

确定主机名称
```bash
    [root@dev ~]# cat /etc/hostname
    dev.totemtec.com
```

确定自己的主机名映射
```bash
    [root@dev ~]# vi /etc/hosts
	127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
	::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
	192.168.1.16 dev.totemtec.com
```

关闭SELinux
```bash
    [root@dev ~]# sestatus
    SELinux status:                 disabled
```

关闭防火墙
```bash
    [root@dev ~]# firewall-cmd --state
    running
```

更新CentOS到最新的版本
```bash
    [root@dev ~]# yum update -y
```

# 2. 前提条件

创建用户和组
```bash
    [root@dev ~]# groupadd oinstall
    [root@dev ~]# groupadd dba
    [root@dev ~]# useradd -g oinstall -G dba oracle
    [root@dev ~]# passwd oracle
```

下载Oracle 11G Release 2，略

   http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

安装解压工具
```bash
    [root@dev ~]# yum install -y zip unzip
```

解压到/stage目录
```bash
    [root@centos7 ~]# unzip linux.x64_11gR2_database_1of2.zip -d /stage/
    [root@centos7 ~]# unzip linux.x64_11gR2_database_2of2.zip -d /stage/
    [root@centos7 ~]# chown -R oracle:oinstall /stage/
```

设置/etc/sysctl.conf
```bash
    [root@dev ~]# vi /etc/sysctl.conf
```

增加下列内容
```bash
    fs.aio-max-nr = 1048576
    fs.file-max = 6815744
    kernel.shmall = 2097152
    kernel.shmmax = 1987162112
    kernel.shmmni = 4096
    kernel.sem = 250 32000 100 128
    net.ipv4.ip_local_port_range = 9000 65500
    net.core.rmem_default = 262144
    net.core.rmem_max = 4194304
    net.core.wmem_default = 262144
    net.core.wmem_max = 1048586
```

检查并应用新值
```bash
    [root@dev ~]# sysctl -p
    [root@dev ~]# sysctl -a
```
    
增大oracle用户限制
```bash
    [root@dev ~]# vi /etc/security/limits.conf
```

增加下列内容
```bash
    oracle soft nproc 2047
    oracle hard nproc 16384
    oracle soft nofile 1024
    oracle hard nofile 65536
    oracle soft stack 10240
```

修改配置文件/etc/pam.d/login
```bash
    [root@dev ~]# vi /etc/pam.d/login
```

增加下列内容
```bash
    session    required     pam_limits.so
```

安装需要的包
```bash
    [root@dev ~]# yum install -y binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 \
    glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 \
    libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 \
    libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64
    
    [root@dev ~]# yum install -y unixODBC.x86_64 unixODBC-devel.x86_64
```

创建oracle安装目录和数据目录
```bash
    [root@centos7 ~]# mkdir /data/oracle
    [root@centos7 ~]# mkdir /data/oradata
    [root@centos7 ~]# chown -R oracle:oinstall /data/oracle
    [root@centos7 ~]# chown -R oracle:oinstall /data/oradata
    [root@centos7 ~]# chmod -R 775 /data/oracle
    [root@centos7 ~]# chmod -R 775 /data/oradata
    [root@centos7 ~]# chmod g+s /data/oracle
    [root@centos7 ~]# chmod g+s /data/oradata
```

# 3. 静默安装

用root用户编辑一个配置文件
```bash
    [root@centos7 ~]# vi /etc/oraInst.loc
```

内容如下
```bash
    inventory_loc=/data/oracle/oraInventory
    inst_group=oinstall
```

修改权限
```bash
    [root@centos7 ~]# chown oracle:oinstall /etc/oraInst.loc
    [root@centos7 ~]# chmod 664 /etc/oraInst.loc
```

准备一个安装配置文件
```bash
    [oracle@centos7 ~]# cp /stage/database/response/db_install.rsp /stage/database/response/my_db_install.rsp
```

修改下列内容
```bash
    oracle.install.option=INSTALL_DB_SWONLY
    UNIX_GROUP_NAME=oinstall
    INVENTORY_LOCATION=/etc/oraInv
    ORACLE_BASE=/data/oracle
    ORACLE_HOME=/data/oracle/product/11.2.0/db1
        
    oracle.install.db.config.starterdb.type=GENERAL_PURPOSE
    oracle.install.db.config.starterdb.globalDBName=db1
    oracle.install.db.config.starterdb.SID=db1
    oracle.install.db.InstallEdition=EE
    oracle.install.db.DBA_GROUP=dba
    oracle.install.db.OPER_GROUP=dba
    oracle.install.db.config.starterdb.password.ALL=manager
    oracle.install.db.config.starterdb.dbcontrol.enableEmailNotification=false
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
    DECLINE_SECURITY_UPDATES=true
```

安装
```bash
    [oracle@centos7 ~]# ./runInstaller -silent -responseFile /home/oracle/database/response/my_db_install.rsp
```

耐心等待完成提示吧
```bash
    /data/oracle/product/11.2.0/db1/root.sh
    要执行配置脚本, 请执行以下操作:
	     1. 打开一个终端窗口
	     2. 以 "root" 身份登录
	     3. 运行脚本
	     4. 返回此窗口并按 "Enter" 键继续

    Successfully Setup Software.
```
  
以root用户新开一个控制台登入，并执行提示中的脚本
```bash
    [root@centos7 ~]# /data/oracle/product/11.2.0/db1/root.sh
```

# 4. 设置oracle环境变量
```bash
    [oracle@centos7 ~]# vi /home/oracle/.bash_profile
```

增加如下内容
```bash
    TMPDIR=$TMP; export TMPDIR
    ORACLE_BASE=/data/oracle; export ORACLE_BASE
    ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db1; export ORACLE_HOME
    ORACLE_SID=db1; export ORACLE_SID
    PATH=$ORACLE_HOME/bin:$PATH; export PATH
    LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64; export LD_LIBRARY_PATH
    CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH
```

生效环境变量
```bash
    [oracle@centos7 ~]$ . .bash_profile
```

# 5. 创建新数据库

准备数据库配置文件
```bash
    [oracle@centos7 ~]# cp /home/oracle/database/response/dbca.rsp /home/oracle/database/response/my_dbca.rsp
    [oracle@centos7 ~]# vi /home/oracle/database/response/my_dbca.rsp
```

编辑下面内容
```bash
    GDBNAME = "db1"
    SID = "db1" 
    SYSPASSWORD = "password"
    SYSTEMPASSWORD = "password"
    CHARACTERSET = "AL32UTF8"
    NATIONALCHARACTERSET= "UTF8" 
```

创建数据库
```bash
    [oracle@centos7 ~]# dbca -silent -responseFile /home/oracle/database/response/my_dbca.rsp
```

这个时候会看到提示和进度
```bash
    Copying database files
    1% complete
    26% complete
    Creating and starting Oracle instance
    40% complete
    61% complete
    Completing Database Creation
    70% complete
    100% complete
```

# 6. 创建监听器
```bash
    [oracle@centos7 ~]$ netca /silent /responsefile /home/oracle/database/response/netca.rsp
```
执行完成会在 $ORACLE_HOME/network/admin目录下生成sqlnet.ora和listener.ora两个文件。


# 7. 测试
```bash
    [oracle@centos7 ~]$ sqlplus / as sysdba

    SQL> select status from v$instance;

    STATUS

    ------------

    OPEN
```
设置了密码的话，需要用如下方式登入
```bash
    [oracle@centos7 ~]$ sqlplus sys as sysdba
```