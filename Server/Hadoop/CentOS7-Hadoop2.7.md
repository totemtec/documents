# Haddop 2.7.2 单机部署

下载

https://hadoop.apache.org/release/2.7.2.html

https://archive.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz

# 安装依赖

```bash
yum install -y ssh rsync
```

# 下载解压

```bash
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz
tar xvzf hadoop-2.7.2.tar.gz
mv hadoop-2.7.2 /opt/hadoop
cd /opt/hadoop
```

# 修改配置

如果已经配置了 JAVA_HOME 可以省略这步

```bash
vi etc/hadoop/hadoop-env.sh

# set to the root of your Java installation
export JAVA_HOME=/usr/java/default
```

# 运行 hadoop

```bash
cd /opt/hadoop/
bin/hadoop version
```

# 单机运行 hadoop

```bash
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar grep input output 'dfs[a-z.]+'
cat output/*
```

执行成功后如下所示，输出了作业的相关信息，输出的结果是符合正则的单词 dfsadmin 出现了1次

注意，Hadoop 默认不会覆盖结果文件，因此再次运行上面实例会提示出错，需要先将 output 删除。

# 配置环境变量

```bash
echo -e "\n\n\
export HADOOP_HOME=/opt/hadoop \n\
export PATH=\$HADOOP_HOME/bin:\$PATH \n\
"\
>> /etc/profile
```