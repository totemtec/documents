# Spark 2.4.3 On YARN

参考文档
> https://spark.apache.org/docs/2.4.3/running-on-yarn.html

Spark Security 默认是关闭的
> https://spark.apache.org/docs/2.4.3/security.html

还未完成搭建，需要继续读文档

> https://blog.csdn.net/zhanglong_4444/article/details/103223763

# 下载解压

```bash
wget https://archive.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
tar xzvf spark-2.4.3-bin-hadoop2.7.tgz
mv spark-2.4.3-bin-hadoop2.7 /opt/spark
cd /opt/spark
```

# 环境变量
```bash
echo -e "\n\n\
export SPARK_HOME=/opt/spark \n\
export PATH=\$SPARK_HOME/bin:\$PATH \n\
"\
>> /etc/profile
```

# 配置说明

`HADOOP_CONF_DIR` 和 `YARN_CONF_DIR` 这两个变量是 YARN，连接 Hadoop 集群用的。用于向 HDFS 写入数据并连接到 YARNResourceManager。这个目录中的配置将分发到 YARN 集群，以便各个节点使用同样的配置。

YARN 上运行 Spark 有两种部署模式。cluster 模式下，Spark driver 运行在 YARN 管理的主进程内，启动完成后客户端就可以关闭了。client 模式下，driver 运行在客户端进程内，application master 仅用于向 YARN 请求资源。

其他集群管理器用 --master 参数指定 master 的地址，YARN 模式时不同，ResourceManager 的地址是从 Hadoop 配置中取得的。所以这里 --master 参数就是 yarn 。


# 修改配置文件

```bash
cd conf
cp spark-env.sh.template spark-env.sh

vi spark-env.sh
```

```bash
SPARK_CONF_DIR=/opt/spark/conf  
HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop  
YARN_CONF_DIR=/opt/hadoop/etc/hadoop  
SPARK_HISTORY_OPTS="-Dspark.history.retainedApplications=3 -Dspark.history.fs.logDirectory=hdfs://master/spark/logs"
```

```bash
cp spark-defaults.conf.template spark-defaults.conf
vi spark-defaults.conf
```

```
spark.master                     yarn
spark.eventLog.enabled           true
spark.eventLog.dir               hdfs://master/spark/logs
spark.serializer                 org.apache.spark.serializer.KryoSerializer
spark.yarn.jars                  hdfs://master/spark/jars/*
```

# 上传 Spark 包

```bash
hdfs dfs -mkdir /spark  
hdfs dfs -mkdir /spark/logs  
hdfs dfs -mkdir /spark/jars  
  
cd /opt/spark
hdfs dfs -put jars/* /spark/jars/  
 
hadoop dfs -ls /spark/jars
```

# 测试

```bash
cd  /opt/spark
./conf/spark-env.sh
 
./bin/spark-submit --class org.apache.spark.examples.SparkPi \
    --master yarn \
    --deploy-mode cluster \
    --driver-memory 4g \
    --executor-memory 2g \
    --executor-cores 1 \
    --queue thequeue \
    examples/jars/spark-examples*.jar \
    10
```

export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"