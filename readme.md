编译版本号自动化脚本工具
----

## 使用方法
- 执行`version_gen.sh`, 需要2个参数
    - 参数1: 使用的版本模版文件的路径
    - 参数2: 生成的版本文件路径

## 例子
```
sh version_gen.sh version.h.template version.h
```

## 填坑
在使用的过程中, 可能出现类似如下的错误:
```
$'***\r': command not found
```
不要慌, 这是因为dos和unix环境下, 2者的回车换行用法不一样导致的.
- dos: 使用"\r\n", 十六进制是0D0A 
- unix: 使用"\n", 十六进制是0A

可以使用工具`dos2unix`在他们之间进行转码

#### 如何优雅的解决:
- windows下: 使用git for windows安装目录的bin下的sh.exe, 如`C:\Git\bin`路径下, 有一个`sh.exe`, 将其加入PATH变量即可
- linux下: 无需其它操作