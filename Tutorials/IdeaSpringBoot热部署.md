# IdeaSpringBoot热部署
- Gradle 中引入 spring-boot-devtools，设置Build Project 后可以自动重启
```
developmentOnly 'org.springframework.boot:spring-boot-devtools'
```

- 修改 Run Configurations，设置后静态文件和Thymeleaf模板修改后立即生效
```
菜单【Run】-【Edit Configurations】-【Spring Boot】-【YourApplication】-【Modify Options】
    【On 'Update' Action】- 选中【Update classes and resources】
    【On frame deactivation】- 选中【Update classes and resources】
```
