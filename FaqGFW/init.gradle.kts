// from https://gist.github.com/bennyhuo/af7c43cc4831661193605e124f539942

fun RepositoryHandler.enableMirror() {
    all {
        if (this is MavenArtifactRepository) {
            val originalUrl = this.url.toString().removeSuffix("/")
            urlMappings[originalUrl]?.let {
                logger.lifecycle("Repository[$url] is mirrored to $it")
                this.setUrl(it)
            }
        }
    }
}

val urlMappings = mapOf(
    "https://repo.maven.apache.org/maven2" to "https://mirrors.tencent.com/nexus/repository/maven-public/",
    "https://dl.google.com/dl/android/maven2" to "https://mirrors.tencent.com/nexus/repository/maven-public/",
    "https://plugins.gradle.org/m2" to "https://mirrors.tencent.com/nexus/repository/gradle-plugins/"
)

gradle.allprojects {
    buildscript {
        repositories.enableMirror()
    }
    repositories.enableMirror()
}

gradle.beforeSettings {
    pluginManagement.repositories.enableMirror()
    // 6.8 及更高版本执行 DependencyResolutionManagement 配置
    if (gradle.gradleVersion >= "6.8") {
        val getDrm = settings.javaClass.getDeclaredMethod("getDependencyResolutionManagement")
        val drm = getDrm.invoke(settings)
        val getRepos = drm.javaClass.getDeclaredMethod("getRepositories")
        val repos = getRepos.invoke(drm) as RepositoryHandler
        repos.enableMirror()
        println("Gradle ${gradle.gradleVersion} DependencyResolutionManagement Configured $settings")
    } else {
        println("Gradle ${gradle.gradleVersion} DependencyResolutionManagement Ignored $settings")
    }
}