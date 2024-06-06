# 导入导出镜像

```bash
docker save -o <path for generated tar file> <image name>
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