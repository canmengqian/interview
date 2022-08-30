1. 在Kubenetes中，**所有的容器均在[Pod](https://www.kubernetes.org.cn/tags/pod)中运行**,一个Pod可以承载一个或者多个相关的容器，在后边的案例中，同一个Pod中的容器会部署在同一个物理机器上并且能够共享资源**。一个Pod也可以包含O个或者多个磁盘卷组（volumes**）,这些卷组将会以目录的形式提供给一个容器，或者被所有Pod中的容器共享，对于用户创建的每个Pod,系统会自动选择那个健康并且有足够容量的机器，然后创建类似容器的容器,当容器创建失败的时候，容器会被node agent自动的重启,这个node agent叫**kubelet**,但是，如果是Pod失败或者机器，它不会自动的转移并且启动，除非用户定义了 **replication controller。**
2. 所有Kubernetes中的资源，比如Pod,都通过一个叫URI的东西来区分，**这个URI有一个UID,URI的重要组成部分是：对象的类型（比如pod），对象的名字，对象的命名空间**，对于特殊的对象类型，在同一个命名空间内，所有的名字都是不同的，在对象只提供名称，不提供命名空间的情况下，这种情况是假定是默认的命名空间。UID是时间和空间上的唯一
3.  核心组件
   1. Master 
      1. scheduling
      2. Rest(API SERVER)
      3. storage
      4. controller manager
   2. Node 
      1. kubelet
      2. proxy
      3. pod
      4. docker