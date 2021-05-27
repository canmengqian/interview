# Zookeeper知识点

[TOC]

## ZooKeeper的应用场景

### 分布式系统带来的问题

- 消息延迟
- 处理器性能
- 时钟偏移

### zookeeper解决了什么问题

- 保障强一致性、有序性和持久性。

- 实现通用的同步原语的能力。

- ·在实际分布式系统中，并发往往导致不正确的行为。ZooKeeper提供了一种简单的并发处理机制。

### Zookeeper不适用场景

## 客户端和会话

### 客户端如何发起一次请求处理

1. 初始化ZooKeeper对象,设置ClientWatchManager和ClientWatchManager。
2. 创建并初始化客户端网络连接器：ClientCnxn。创建TCP socket通过sendThread发送请求,把该请求包装成网络I/O层的Packet对象，放入请求发送队列outgoingQueue中去。
3. **处理响应**，ClientCnxnSocket会对接收到的服务端响应进行反序列化，得到Connect
   Response对象。SendThread会生成一个事件SyncConnected-None，EventThread不断地从waitingEvents队列中取出待处理的Watcher对象，然后直接调用该对象的process接口方法，以达到触发Watcher的目的。
4. ![Screenshot_20200928-131352](C:\Users\ASUS\Nox_share\ImageShare\Screenshots\Screenshot_20200928-131352.png)

### ZooKeeper客户端有哪些组件,功能作用是什么

- **ClientCnxn**是ZooKeeper客户端的核心工作类，负责维护客户端与服务端之间的网络连接并进行一系列网络通信。

## ZooKeeper的Watcher机制

​
ZooKeeper允许客户端向服务端注册一个Watcher监听，当服务端的一些指定事件触发了这个Watcher，那么就会向指定客户端发送一个事件通知来实现分布式的通知功能。客户端在向ZooKeeper服务器注册Watcher的同时，会将Watcher对象存储在客户端的WatchManager中。当ZooKeeper服务器端触发Watcher事件后，会向客户端发送通知，客户端线程从WatchManager中取出对应的Watcher对象来执行回调逻辑

Watcher的工作流程

### Watcher有哪些事件

![watcher事件](C:\Users\ASUS\Nox_share\ImageShare\Screenshots\watcher事件.png)

## ZooKeeper集群

### 集群间角色的分配和功能

- **Leader:**事务请求的唯一调度和处理者，保证集群事务处理的顺序性。集群内部各服务器的调度者.leader通过请求处理链完成对请求的处理,节点写入,事务处理和数据持久化等流程。
- **Follower**:处理客户端非事务请求，转发事务请求给Leader服务器。参与事务请求Proposal的投票。参与Leader选举投票。
- **Observer**
  ：充当了一个观察者的角色——其观察ZooKeeper集群的最新状态变化并将这些状态变更同步过来。Observer服务器在工作原理上和Follower基本是一致的，对于非事务请求，都可以进行独立的处理，而对于事务请求，则会转发给Leader服务器进行处理。和Follower唯一的区别在于，Observer不参与任何形式的投票，包括事务请求Proposal的投票和Leader选举投票

### Leader的选举

1. **发出投票:**将自己作为Leader服务器来进行投票，每次投票包含的最基本的元素包括：所推举的服务器的myid和ZXID，我们以（myid，ZXID）的形式来表示，每个zk服务都有一个**QuorumCnxManager**
   ，负责各台服务器之间的底层Leader选举过程中的网络通信。在**QuorumCnxManager**
   使用3888端口作为选举通信端口,内部维护了一系列的队列，用于保存接收到的、待发送的消息，以及消息的发送器。为了避免两台机器之间重复地创建TCP连接，ZooKeeper设计了一种建立TCP连接的规则：只允许SID大的服务器主动和其他服务器建立连接，否则断开连接
2. 接收并处理投票:
    1. 优先检查ZXID。ZXID比较大的服务器优先作为Leader
    2. 如果ZXID相同的话，那么就比较myid。myid比较大的服务器作为Leader服务器
3. 统计投票：大于集群机器数量的一半，即大于或等于（n/2+1）,已经选出了Leader。

### 服务端如何完成对客户端读写请求的处理

1. 接收请求:由NIOServerCnxn负责统一接收来自客户端的所有请求.请求进来后,zk需要对该请求进行反序列化,并检查该请求的ZXID是否合法,设置session 超时和重连等操作
2. **注册Session ，向SessionTracker中注册会话**
   。SessionTracker中维护了两个比较重要的数据结构，分别是sessionsWithTimeout和sessionsById。前者根据sessionID保存了所有会话的超时时间，而后者则是根据sessionID保存了所有会话实体
3. 事务处理,通过ProposalRequestProcessor等处理器链完成事务的预处理和持久化.
4. 发起对该次事务请求的提案,集群内发起投票是否允许该事务进行提交
5. 该事务放入commitProposal队列中。commitProposal队列用来保存最近被提交的事务请求，对事务结果进行响应,创建响应体并对响应体进行序列化,

## 数据存储

### ZooKeeper节点类型

- 持久节点（PERSISTENT）
    - 每个父节点都会为它的第一级子节点维护一份顺序，用于记录下每个子节点创建的先后顺序。基于这个顺序特性，在创建子节点的时候，可以设置这个标记。
- 临时节点（EPHEMERAL）
- 如果客户端会话失效，那么这个节点就会被自动清理掉。注意，这里提到的是客户端会话失效，而非TCP连接断开
- 顺序节点（SEQUENTIAL）
    - 临时顺序节点的基本特性和临时节点也是一致的，同样是在临时节点的基础上，添加了顺序的特性

### ZooKeeper内存数据模型

- **DateTree**用于存储所有ZooKeeper节点的路径、数据内容及其ACL信息等，底层的数据结构其实是一个典型的ConcurrentHashMap键值对结构
- **ZKDatabase**
  ，负责管理ZooKeeper的所有会话、DataTree存储和事务日志。ZKDatabase会定时向磁盘dump快照数据，同时在ZooKeeper服务器启动的时候，会通过磁盘上的事务日志和快照数据文件恢复成一个完整的内存数据库。

### ZooKeeper数据日志和事务日志

#### 数据日志的格式,生成规则,写入流程

- **生成规则**
    1. 在运行过程中会在该目录下建立一个名为version-2的目录，该目录确定了当前ZooKeeper使用的快照数据格式版本号。
    2. 是使用ZXID的十六进制表示来作为文件名后缀，该后缀标识了本次数据快照开始时刻的服务器最新ZXID,确定数据恢复的起始点
    3. 快照数据文件没有采用“预分配”机制

- **内存节点数据写入数据日志流程**
    1. 采取“**过半随机**”策略，即符合如下条件就进行数据快照：logCount> (snapCount / 2 + randRoll)
       ,其中logCount代表了当前已经记录的事务日志数量，randRoll为1～snapCount/2之间的随机数
    2. 创建一个单独的异步线程来进行数据快照
    3. 从ZKDatabase中获取到DataTree和会话信息，序列化**文件头信息**，这里的文件头和事务日志中的一致，同样也包含了魔数、版本号和dbid信息。然后再对**会话信息和DataTree分别进行序列化**
       ，同时生成一个Checksum，一并写入快照数据文件中去。

#### 事务日志的格式,生成规则,写入流程

- **生成规则**
    1. 配置一个目录：dataDir
    2. 这些文件的文件大小都是64MB。
    3. 文件名后缀是一个十六进制数字，高32位代表当前Leader周期（epoch），低32位则是真正的操作序列号
    4. 当检测到当前事务日志文件剩余空间不足4096字节（4KB）时，开始进行文件空间扩容。在现有文件大小的基础上，将文件大小增加64MB，然后使用“0”（\0）填充这些被扩容的文件空间

### ZooKeeper重启间加载数据流程

​ 初始化ZKDatabase和DataTree，获取最新的至多100个快照文件（如果磁盘上仅存在不到100个快照文件，那么就获取所有这些快照文件）,根据这个快照文件的文件名就可以解析出一个最新的ZXID

### ZooKeeper 数据同步

​
集群完成Leader选举之后，Learner会向Leader服务器进行注册。当Learner服务器向Leader完成注册后，就进入数据同步环节.Leader服务器一个ACKEPOCH数据包，Leader会从这个数据包中解析出该Learner的currentEpoch和lastZxid。完成**
peerLastZxid**(Learner服务器最后处理的ZXID),**minCommittedLog**(Leader服务器提议缓存队列committedLog中的最小ZXID),**maxCommittedLog** (
Leader服务器提议缓存队列committedLog中的最大ZXID)的初始化

**四种同步场景**

- 直接差异化同步（DIFF同步）
    - 场景:leader工作正常,follwer落后于leader
    - **同步方式**
        - follower上报自己的最后处理的ZXID,如果出现差异,leader将差异化数据发送给follower,并发送NEWLEADER,和DIFF指令
        - follower完成对差异化数据的同步,放入自己的队列中,并返回给leader一个ACK命令,如果同步完成过半,则同步完毕,可以进行对外服务了
- 先回滚再差异化同步(TODO)
    - 场景:leader完成自身写入,准备同步给其他follower时挂了，zk重新进行选举
    - 同步方式:
      - 
- 仅回滚同步
- 全量同步



