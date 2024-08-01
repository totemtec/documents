# 导入导出镜像

```bash
docker commit sim-debug sim-debug:1.0.0
```

```bash
docker save -o ~/Desktop/sim-debug.tar sim-debug:1.0.0
```

```bash
docker load -i <path to image tar file>
```

```
docker save -o c:/myfile.tar centos:16
`````

```
docker save -o C:\path\to\file.tar repository/imagename
```