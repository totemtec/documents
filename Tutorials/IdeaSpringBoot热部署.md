# IdeaSpringBoot热部署

- Idea 修改 Run Configurations，设置后静态文件和Thymeleaf模板修改后立即生效

```
菜单【Run】-【Edit Configurations】-【Spring Boot】-【YourApplication】-【Modify Options】
    【On 'Update' Action】- 选中【Update classes and resources】
    【On frame deactivation】- 选中【Update classes and resources】
```

- Idea 自动编译，设置后 Java文件修改后会自动编译

```
菜单【File】-【Settings】
    【Advanced Settings】-【Compiler】- 勾选【Allow auto-make to start even if developed application is currently running】
    【Build, Execution, Deployment】- 【Compiler】- 勾选【Build project automatically】
```

- build.gradle 中引入 spring-boot-devtools，设置后 Build Project 可以自动重启

```
dependencies {
    ... ...
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
}
```
