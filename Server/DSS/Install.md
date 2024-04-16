# DSS Install

参考文档
> https://github.com/WeBankFinTech/DataSphereStudio-Doc/blob/main/zh_CN/%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2/DSS%26Linkis%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2%E6%96%87%E6%A1%A3%E5%8D%95%E6%9C%BA%E7%89%88.md

系统：CentOS 7.9

1. 下载

```
wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/DataSphereStudio/1.1.2/dss_linkis_one-click_install_20230809.zip
unzip dss_linkis_one-click_install_20230809.zip
```

2. 安装依赖

```
yum install -y telnet tar sed dos2unix unzip zip expect
```

安装 Java 8u22
安装 MySQL 5.7
安装 Python 3.6
安装 Nginx


hostname配置。在安装前用户需要配置hostname到ip的映射


