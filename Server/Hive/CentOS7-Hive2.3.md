# Hive 2.3.3 快速安装部署

参考文档
> https://cwiki.apache.org/confluence/display/Hive/GettingStarted

下载地址
> https://archive.apache.org/dist/hive/hive-2.3.3/

# 下载解压

```bash
wget https://archive.apache.org/dist/hive/hive-2.3.3/apache-hive-2.3.3-bin.tar.gz
tar xvzf apache-hive-2.3.3-bin.tar.gz
mv apache-hive-2.3.3-bin /opt/hive
cd /opt/hive
```

# 配置环境变量


```bash
echo -e "\n\n\
export HIVE_HOME=/opt/hive \n\
export PATH=\$HIVE_HOME/bin:\$PATH \n\
"\
>> /etc/profile 
```

# 创建运行目录

```bash
$HADOOP_HOME/bin/hadoop fs -mkdir       /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir -p    /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w   /tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w   /user/hive/warehouse
```

# 命令行方式启动 hive

```bash
hive

Logging initialized using configuration in jar:file:/opt/hive/lib/hive-common-2.3.3.jar!/hive-log4j2.properties Async: true
Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.

hive> show databases;
hive> show tables;
hive> exit;
```

运行 show databases; 出错如下

```
FAILED: SemanticException org.apache.hadoop.hive.ql.metadata.HiveException: java.lang.RuntimeException: Unable to instantiate org.apache.hadoop.hive.ql.metadata.SessionHiveMetaStoreClient
```

修复命令

```bash
rm -rf $HIVE_HOME/bin/metastore_db
$HIVE_HOME/bin/schematool -initSchema -dbType derby
```