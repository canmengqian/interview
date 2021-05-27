# docker知识点

[TOC]

## Docker 架构

| 概念                   | 说明                                                         |
| :--------------------- | :----------------------------------------------------------- |
| Docker 镜像(Images)    | Docker 镜像是用于创建 Docker 容器的**模板**，比如 Ubuntu 系统。 |
| Docker 容器(Container) | 容器是独立运行的一个或一组应用，是镜像运行时的**实体**。     |
| Docker 客户端(Client)  | Docker 客户端通过命令行或者其他工具使用 Docker SDK (https://docs.docker.com/develop/sdk/) 与 Docker 的守护进程通信。 |
| Docker 主机(Host)      | 一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。       |
| Docker Registry        | Docker 仓库用来保存镜像，可以理解为代码控制中的代码仓库。Docker Hub([https://hub.docker.com](https://hub.docker.com/)) 提供了庞大的镜像集合供使用。一个 Docker Registry 中可以包含多个仓库（Repository）；每个仓库可以包含多个标签（Tag）；每个标签对应一个镜像。通常，一个仓库会包含同一个软件不同版本的镜像，而标签就常用于对应该软件的各个版本。我们可以通过 **<
仓库名>:<标签>** 的格式来指定具体是这个软件哪个版本的镜像。如果不给出标签，将以 **latest** 作为默认标签。 |
| Docker Machine         | Docker Machine是一个简化Docker安装的命令行工具，通过一个简单的命令行即可在相应的平台上安装Docker，比如VirtualBox、 Digital Ocean、Microsoft Azure。 |

![img](https://www.runoob.com/wp-content/uploads/2016/04/576507-docker1.png)

## Docker命令使用

### Docker 容器使用

| 命令                                                    | 作用                                   | 备注                                                         |
| ------------------------------------------------------- | -------------------------------------- | ------------------------------------------------------------ |
| docker command --help                                   | 更深入的了解指定的 Docker 命令使用方法 |                                                              |
| docker stats --help                                     | 查看docker状态帮助命令                 |                                                              |
| docker pull ubuntu                                      | 拉取镜像                               |                                                              |
| docker run -it ubuntu /bin/bash                         | 启动容器                               | -i: 交互式操作。 -t: 终端。 ubuntu: ubuntu 镜像。<br/> /bin/bash：放在镜像名后的是命令，这里我们希望<br />有个交互式 Shell，因此用的是 #/bin/bash |
| docker ps -a                                            | 查看所有的容器                         |                                                              |
| docker start <容器id>                                   | 启动一个已停止的容器                   |                                                              |
| docker run -itd --name ubuntu-test ubuntu /bin/bash     | 后台运行docker                         |                                                              |
| docker stop                                             | 停止容器                               |                                                              |
| docker attach <容器 ID>                                 | 进入容器                               | 如果从这个容器退出，会导致容器的停止。                       |
| docker exec -it /bin/bash                              | 进入容器                               | 如果从这个容器退出，**
不会**导致容器的停止                   |
| docker export <容器 ID> > ubuntu.tar                    | 导出容器                               |                                                              |
| cat docker/ubuntu.tar \| docker import - test/ubuntu:v1 | 导入容器                               |                                                              |
| docker rm -f <容器 ID>                                  | 删除容器                               |                                                              |
| docker port <容器 ID>                                   | 查看容器端口                           |                                                              |
| docker logs -f <容器 ID>                                | 查看 WEB 应用程序日志                  |                                                              |
|                                                         |                                        |                                                              |
|                                                         |                                        |                                                              |

### Docker 镜像命令

| 命令                | 作用               | 备注 |
| ------------------- | ------------------ | ---- |
| docker images       | 出本地主机上的镜像 |      |
| docker search httpd | 搜索镜像           |      |
|                     |                    |      |

### Docker Dockerfile

| 命令     | 作用                                                         | 备注                                                   |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------ |
| **FROM** | 定制的镜像都是基于 FROM 的镜像                               |                                                        |
| **RUN**  | 等同于在终端操作的 shell 命令,RUN ["可执行文件", "参数1", "参数2"] |                                                        |
| COPY     | 从上下文目录中复制文件或者目录到容器里指定路径。             | COPY [--chown=<user>:<group>] <源路径1>...  <目标路径> |
| ENV      | 设置环境变量，定义了环境变量，那么在后续的指令中，就可以使用这个环境变量。 | ENV <key1>=<value1> <key2>=<value2>                    |
| ARG      | 构建参数，与 ENV 作用一至。不过作用域不一样。ARG 设置的环境变量仅对 Dockerfile 内有效，也就是说只有 docker build 的过程中有效，构建好的镜像内不存在此环境变量。 |                                                        |
| VOLUME   | 定义匿名数据卷。在启动容器时忘记挂载数据卷，                 |                                                        |
| EXPOSE   |                                                              |                                                        |
| WORKDIR  | 指定工作目录                                                 |                                                        |
| USER     | 指定执行后续命令的用户和用户组                               | USER <用户名>[:<用户组>]                               |
| ONBUILD  |                                                              |                                                        |