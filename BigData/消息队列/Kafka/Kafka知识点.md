# Kafka知识点

[TOC]

## Kafka基本概念

### Kafka如何做到高吞吐量、低延时

1. 每次写入操作其实都只是把数据写入到操作系统的页缓存（page cache）中,操作系统页缓存是在内存中分配的，所以消息写入的速度非常快。
2. Kafka不必直接与底层的文件系统打交道。所有烦琐的I/O操作都交由操作系统来处理。
3. Kafka写入操作采用追加写入（append）的方式，避免了磁盘随机写操作
4. 使用以sendfile为代表的零拷贝技术加强网络间的数据传输效率

### Topic，Patition,offset的概念

**Topic** 只是一个逻辑概念，代表了一类消息，也可以认为是消息被发送到的地方。通常我们可以使用topic来区分**实际业务**,每个 partition 有自己专属的 partition 号，通常是从0开始的。**
用户对partition** 唯一能做的操作就是在**消息序列的尾部追加写入消息**。partition 上的每条消息都会被分配一个唯一的序列号——按照Kafka的术语来讲，该序列号被称为位移（offset），Kafka
中的一条消息其实就是一个**<topic,partition,offset>三元组**（tuple），通过该元组值我们可以在 Kafka 集群中找到唯一对应的那条消息。

## Kafka消息生产与消费

### 生产者的投递流程

当 producer发送一条消息给 Kafka集群时，这条消息会被发送到指定 **topic分区leader所在的broker**上，producer等待从该leader
broker返回消息的写入结果（当然并不是无限等待，是有超时时间的）以确定消息被成功提交。这一切完成后producer可以继续发送新的消息。Kafka能够保证的是consumer永远不会读取到尚未提交完成的消息

### 生产者的分区策略

### 生产端消息发送和重试机制

通过 Java提供的 Future同时实现了同步发送和异步发送+回调（Callback）两种发送方式。

1. 分区的 leader副本不可用，这通常出现在 leader换届选举期间。
2. controller 当前不可用，需要进行controller选举才能恢复
3. 网络瞬时故障导致的异常

### 生产端/消费端能够保证投递的语义和消息有序性吗/如何保证精确一次处理

- **在非幂等和非事务情况下:**
    - producer在比较极端的情况下，同一条消息可能会被发送多次，默认提供的就是**至少一次**语义。
    - consumer 首先获取若干消息，**先提交位移**，之后再开始**处理消息**，提供的是最多一次的语义
    - consumer 首先获取若干消息，**先处理消息**，之后再**提交位移**，提供的是**至少一次**的语义

- **通过幂等性进行设置**
    - 发送到 broker端的每批消息都会被赋予一**个序列号**（sequence number）用于消息去重。但是和 TCP 不同的是，这个序列号不会被丢弃，相反
      Kafka把它们保存在底层日志中,还会为每个producer实例分配一个**producer id**（下称PID），发送消息的序列号**小于或等于**broker端保存的序列号，那么broker会**拒绝这条消息的写入**
      操作。当前设计只能保证单个 producer实例的 EOS语义，而无法实现多个producer实例一起提供EOS语义

- **通过事务支持**
    - 某个 producer 实例**挂掉**了，Kafka 能够保证下一个实例**首先完成之前未完成的事务**，从而总是保证状态的一致性。
    - 对于消费者来说,使用事务也**不一定能保证精准一次消费**
        1. 对于compacted的topic而言，事务中的消息可能已经被**删除**了。
        2. 事务可能跨多个日志段（log segment），因此若**老的日志段被删除**，用户将丢失事务中的部分消息。
        3. consumer程序可能使用 seek方法定位事务中的任意位置，也可能造成部分消息的丢失。
        4. consumer可能**选择不消费事务中**的所有消息，即无法保证读取事务的全部消息。

### 消费端如何实现重平衡 (Rebalance)

consumer group会立即将已崩溃 **consumer负责的分区转交给其他 consumer**来负责,

### 怎么对生产端进行调优来保障投递语义和消息去重

| 参数                   | 说明                                                         |
| ---------------------- | ------------------------------------------------------------ |
| **acks**               | **acks = 0**：设置成 0 表示 producer 完全不理睬 leader broker 端的处理结果。此时，**
producer发送消息后立即开启下一条消息的发送，根本不等待leader
broker端返回结果**。由于不接收发送结果，因此在这种情况下 producer.send 的回调也就完全失去了作用，即用户无法通过回调机制感知任何发送过程中的失败，所以 acks=0时producer并**
不保证消息会被成功**发送。但凡事有利就有弊，由于不需要等待响应结果，通常这种设置下producer的**吞吐量**是最高的<br />**acks = all或者-1**：表示当发送消息时，leader broker不仅会将消息写入**
本地日志**，同时还会等待 ISR 中所有**
其他副本都成功写入**它们各自的本地日志后，才发送响应结果给producer。显然当设置acks=all时，只要ISR中至少有一个副本是处于“存活”状态的，那么这条消息就肯定不会丢失，因而可以达到最高的消息持久性，但通常这种设置下producer的吞吐量也是最低的。<br />**
acks = 1**：是0和 all 折中的方案，也是默认的参数值。producer 发送消息后 leader broker **
仅将该消息写入本地日志**，然后便发送响应结果给 producer，而无须等待 ISR中其他副本写入该消息。那么此时只要该leader broker一直存活，Kafka就能够保证这条消息不丢失。这实际上是一种折中方案，既可以达到适当的消息持久性，同时也保证了producer端的吞吐量 |
| **buffer.memory**      | 用于缓存消息的缓冲区，默认值 32MB,首先创建一块内存缓冲区用于保存待发送的消息，然后由另一个专属线程负责从缓冲区中读取消息执行真正的发送。如果消息生产过快,会**
产生缓冲区消息积压**,会抛出异常,所以需要确定好缓冲区的大小 |
| **compression.type**   | 降低网络 **I/O传输开销**从而提升整体吞吐量，但也会增加 producer端机器 **CPU开销**,目前 Kafka支持3种压缩算法：**GZIP、Snappy和
LZ4。** |
| **retries**            | 1.重试可能造成消息的重复发送<br />2.重试可能造成消息的乱序   |
| **batch.size**         | 参数默认值是16384，即16KB。                                  |
| linger.ms              | 该参数默认值是0，表示消息需要被立即发送，无须关心 batch 是否已被填满 |
| **
request.timeout.ms** | 默认是30秒。这就是说，如果 broker在30秒内都没有给producer发送响应，那么producer就会认为该请求超时了，并在回调函数中显式地抛出TimeoutException异常交由用户处理。 |
|                        |                                                              |

### 怎么对消费端进行参数设置

| 参数                        | 说明                                                         |
| --------------------------- | ------------------------------------------------------------ |
| **session.timeout.ms**      | coordinator检测 consumer崩溃的情况，从而更快地开启 rebalance，避免造成更大的消费滞后（consumer lag）。目前该参数的默认值是10秒 |
| **max.poll.interval.ms**    | 用于设置消息处理逻辑的最大时间                               |
| **auto.offset.reset**       | •earliest：指定从最早的位移开始消费。注意这里最早的位移不一定就是0。<br />•latest：指定从最新处位移开始消费 |
| **
enable.auto.commit**      | 是否自动提交位移。若设置为 true，则 consumer在后台自动提交位移；否则，用户需要手动提交位移。对于有较强“精确处理一次”语义需求的用户来说，最好将该参数设置为false，由用户自行处理位移提交问题。 |
| **fetch.max.bytes**         | 指定了 consumer 端单次获取数据的最大字节数                   |
| **max.poll.records**        | 最大的拉取数量                                               |
| **heartbeat.interval.ms**   |                                                              |
| **
connections.max.idle.ms** | Kafka会定期地关闭空闲 Socket连接导致下次 consumer处理请求时需要重新创建连向 broker的 Socket连接。当前默认值是9分钟。推荐设置该参数值为-1，即不要关闭这些空闲连接 |

## Kafka集群

### Kafka日志存储

### Kafka水印

### Controller的作用

### Kafka如何实现partition备份策略

- 分为领导者副本（leader replica）和追随者副本（follower replica）。**follower replica** 是不能提供服务给客户端的，也就是说**不负责响应客户端发来的消息写入和消息消费请求**
  。它只是被动地向领导者副本（leader replica）获取数据，而一旦 leader replica 所在的broker宕机，Kafka会从剩余的 replica中选举出新的 leader继续提供服务。
- Kafka保证同一个partition的多个replica一定不会分配在同一台broker上

### Kafka主从(leader 和 )作用和选举机制

## Kafka参数优化

### 平时对Kafaka做过哪些配置和优化,从broker,JVM，生产者,消费者角度

#### broke优化

| 参数                             | 备注                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| log.dirs                         | 指定了 Kafka 持久化消息的目录。该参数可以设置多个目录，以逗号分隔，指定多个目录的做法通常是被推荐的，因为这样 Kafka 可以把**
负载均匀地分配**到多个目录下。 |
| zookeeper.connect                | 必须要设置                                                   |
| unclean.leader.election.enable   | ISR中的所有副本都有资格随时成为新的leader，但若ISR变空而此时leader又宕机了，如果发生这种情况，Kafka**
不允许从剩下存活的非ISR副本中**选择一个当leader。因为如果允许，这样做固然可以让Kafka继续提供服务给 clients，但会造成**消息数据的丢失** |
| delete.topic.enable              | 是否允许 Kafka删除 topic。默认情况下，Kafka集群允许用户删除topic及其数据。 |
| log.retention.{hours,minutes,ms} | 日志的留存时间。默认的留存时间是7天                          |
| log.retention.bytes              | 大小**
超过该参数的**分区日志而言，Kafka 会自动清理该分区的过期日志段文件。该参数默认值是-1，表示 Kafka 永远不会根据消息日志文件总大小来删除日志。 |
| num.network.threads              | 控制了一个broker在后台用于处理网络请求的线程数，默认是3，负责转发请求，它会将接收到的请求转发到后面的处理线程中。用户需要不断地监控 NetworkProcessorAvgIdlePercent JMX 指标。如果该指标持续低于0.3，建议适当增加该参数的值 |
| num.io.threads                   |                                                              |
| message.max.bytes                | Kafka broker能够接收的最大消息大小，默认是977KB              |
|                                  |                                                              |

#### 操作系统参数设置

| 参数设置                                                     |
| ------------------------------------------------------------ |
| **文件描述符限制：**Kafka 会频繁地创建并修改文件系统中的文件，这包括消息的日志文件、索引文件及各种元数据管理文件等。 |
| **Socket缓冲区大小：**做远距离的数据传输，那么建议将 OS级别的 Socket缓冲区调大，比如增加到 128KB，甚至更大 |
| **关闭 swap：** 其实这是很多使用磁盘的应用程序的常规调优手段，具体命令为 sysctl vm.swappiness = <一个较小的数>，即大幅度降低对 swap 空间的使用，以免极大地拉低性能。 |
| **设置更长的flush时间：** 我们知道Kafka依赖OS页缓存的“刷盘”功能实现消息真正写入物理磁盘，默认的刷盘间隔是 **5 秒。建议2分钟** |

#### 配置参照

- [broker配置](https://kafka.apache.org/documentation/#brokerconfigs)

