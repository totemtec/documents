# Gradle使用国内镜像

### 项目配置

##### 加速 gradle 包下载

PROJECT_HOME/gradle/wrapper/gradle-wrapper.properties

```properties
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-7.3.3-bin.zip
```

##### 加速依赖包下载

配置 repositories

```groovy
// Groovy
repositories {
    maven { url "https://maven.aliyun.com/repository/public" }
    maven { url "https://maven.aliyun.com/repository/google" }
    maven { url "https://maven.aliyun.com/repository/central" }
    maven { url "https://maven.aliyun.com/repository/gradle-plugin" }
    google()
    mavenCentral()
}
```

```kotlin
// Kotlin Script
repositories {
    maven { url = uri("https://maven.aliyun.com/repository/public") }
    maven { url = uri("https://maven.aliyun.com/repository/google") }
    maven { url = uri("https://maven.aliyun.com/repository/central") }
    maven { url = uri("https://maven.aliyun.com/repository/gradle-plugin") }
    google()
    mavenCentral()
}
```

##### 全局镜像加速

- USER_HOME/.gradle/init.gradle
- USER_HOME/.gradle/init.gradle.kts

##### 增加镜像可以参考

https://developer.aliyun.com/mvn/view