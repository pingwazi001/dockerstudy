- [课程说明](#课程说明)
- [环境安装](#环境安装)
- [Docker简介](#docker简介)
  - [核心概念](#核心概念)
  - [与虚拟机对比](#与虚拟机对比)
- [常用命令](#常用命令)
  - [镜像](#镜像)
  - [容器](#容器)
- [数据卷](#数据卷)
  - [具名和匿名挂载](#具名和匿名挂载)
  - [数据卷容器](#数据卷容器)
- [网络](#网络)
- [Dockerfile命令](#dockerfile命令)
- [实战](#实战)


# 课程说明
课程目的：帮助从未接触过docker的同学快速入门并上手使用，在教程最后会有一个实战阶段。  
操作系统：Macos物理机+Centos虚拟机  
编程语言：Golang为主  
Github：[课程文档、源码](https://github.com/pingwazi0101/dockerstudy)  
DockerHub：[实战课的镜像](https://hub.docker.com/r/pingwazi0101/webapp)  
Docker官方文档：[docs.docker.com](https://docs.docker.com/)  

# 环境安装
参考官网

# Docker简介
***Build, Ship and Run Any App, Anywhere（一次封装，到处运行）***

## 核心概念
注册服务器、镜像仓库、镜像、容器  
- 注册服务器：存放镜像仓库  
- 镜像仓库：存放镜像
- 镜像：创建容器的模板
- 容器：一个镜像的运行实例，应用程序在容器中运行

## 与虚拟机对比
Docker容器可以类比虚拟机，但比虚拟机启动更快、资源占用更少

# 常用命令
## 镜像
- 查看镜像列表：docker images 或者 docker image ls
- 查看镜像明细：docker inspect 镜像id
- 拉取镜像：docker pull hello-world，指定tag
- 镜像提交历史：docker history 镜像名:tag/id
- 删除镜像：docker rmi 镜像名:tag/镜像id
- 创建镜像tag：docker tag 镜像名:tag 新镜像名:新tag(如果镜像的名称和tag已经存在，那么此命令就是新增。否则是修改)
- 镜像导出：docker save 镜像id > 1.tar  或者 docker save -o 1.tar 镜像id（导出进行的详细信息）
- 镜像导入：docker load < 1.tar  或者 docker load -i 1.tar
- 在组成服务器中搜索镜像仓库：docker search nginx
- docker run 创建并启动一个容器（后面总结）
- docker create 创建一个容器


## 容器
- 查看正在运行的容器：docker ps
- 查看所有容器：docker ps -a
- 容器的启动、暂停、恢复、停止： docker start|pause|unpause|stop 容器id
- 查看容器内的日志：docker logs 容器id
- 删除容器：docker rm 容器id
- 查看容器详情：docker inspect 容器id
- 容器导出：docker export 1.tar 容器id（只是导出当前信息）
- 容器导入：docker import 1.tar 镜像名:tag（是导入为一个镜像）
- 基于当前容器创建一个镜像：docker commit




# 数据卷
## 具名和匿名挂载
-- docker run -v 宿主机地址:容器地址 镜像id
-- docker run -v 数据卷名称:容器地址 镜像id
## 数据卷容器
共享容器的数据卷
-- docker run --volume-from=容器id 镜像id 

# 网络
-- docker run -P 宿主机随机分配一个端口和容器内部开放端口进行绑定
-- docker run -p 宿主机端口:容器端口
-- docker run --link 容器id
-- docker network create mynet 创建一个网络
-- docker run --network mynet 容器id（同一个网络内的容器可以互相ping）

# Dockerfile命令
- arg 定义构建时需要的参数 arg varname=default_varvalue 或者 arg varname 
- from 定义镜像时的基础镜像  from golang:1.17
- label 定义进行的标签 label author=pingwazi
- expose 声明暴露的端口，给dockerfile文件维护者提供信息，在容器启动的时候使用-P命令可以可宿主机的端口进行映射 expose 8080
- env 定义环境变量，在运行的容器中会存在 env username=pingwazi
- entrypoint 容器启动时执行的命令，存在多个命令时只有最后一个生效 entrypoint ["echo","hello"]
- volume 指定数据卷挂载点 volume ["/root","/home"] 或者 volume /root /home
- user 指定容器启动后使用的用户
- workdir 设置run、cmd、entrypoint、copy、add命令的工作目录
- onbuild 当基于此镜像构建新的镜像时执行的命令 onbuild run ["echo","hello"]
- stopsignal 给送给容器退出的信号
- healthcheck 容器健康检查，healthcheck none 禁止容器健康检查，healthcheck --interval=3 --timeout=1 --retries=1 curl --fail http://localhost:8080/ping ||exit 1
- shell 指定shell类型命令所使用的终端类型
- run 执行命令，在进行生成过程中执行
- cmd 执行命令，dockerfile中只有最后一个cmd命令生效，在启动容器时如果指定了命令，dockerfile中的cmd也会失效
- add 添加文件到容器指定目录，文件可以是宿主机上下文目录中的、可以url的、也可以使压缩包(会自动解压)
- copy 拷贝宿主机上下文目录中的文件到容器中


# 实战
- 1、写一个非常简单的go web程序
- 2、编写dockerfile文件
- 3、生成镜像并上传到dockerhub中
- 4、另外一台机器上pull这个镜像，并启动
- 5、浏览器访问
