#!/bin/sh

sudo wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm

sudo rpm -Uvh jdk-17_linux-x64_bin.rpm

java -version

if [[ $? -eq 0 ]]; then
    echo "Java 17 install succeeded"
else
    echo "Java 17 failed"
fi