# RabbitMq知识点

[TOC]

## 交换器、路由键、绑定

## RabbitMq中交换器和队列

### 交换器的类型

1. **fanout** 会把所有发送到该**交换器的消息**发送到所有与该交换器绑定的队列中。
2. **direct**会把消息路由到那些BindingKey和RoutingKey完全匹配的队列中。
3. **topic**：模糊匹配型交换器
4. **headers**:不依赖于路由键的匹配规则来路由消息，而是根据发送的消息内容中的headers属性进行匹配。在绑定队列和交换器时制定一组键值对，当发送消息到交换器时，RabbitMQ会获取到该消息的headers（也是一个键值对的形式），对比其中的键值对是否完全匹配队列和交换器绑定时指定的键值对，如果完全匹配则消息会路由到该队列，否则不会路由到该队列。headers类型的交换器性能会很差，而且也不实用，基本上不会看到它的存在。

### 交换器相关属性设置

| 属性          | 备注                                                         |
| ------------- | ------------------------------------------------------------ |
| durable       | 设置是否持久化。                                             |
| autoDelete：  | 设置是否自动删除。autoDelete设置为true则表示自动删除。自动删除的前提是至少有一个队列或者交换器与这个交换器绑定，之后所有与这个交换器绑定的队列或者交换器都与此解绑。 |
| internal      | 如果是内置的交换器，客户端程序无法直接发送消息到这个交换器中，只能通过交换器路由到交换器这种方式。 |
| mandatory     | 交换器无法根据自身的类型和路由键找到一个符合条件的队列，那么RabbitMQ会调用Basic.Return命令将消息返回给生产者。<br />当mandatory参数设置为false时，出现上述情形，则消息直接被丢弃。 |
| **immediate** | 如果交换器在将消息路由到队列时发现队列上并**不存在消费者**，那么这条消息将**不会存入队**列中。当与路由键匹配的所有队列都没有消费者时，该消息会通过Basic.Return返回至生产者。 |
| 4.1.3         |                                                              |

### 队列类型

- **延迟队列**:指当消息被发送以后，并不想让消费者立刻拿到消息，而是等待特定时间后，消费者才能拿到这个消息进行消费。
- **优先级队列**:具有高优先级的队列具有高的优先权，优先级高的消息具备优先被消费的特权。
- **DLX死信队列**，当消息在一个队列中变成死信（dead message）之后，会转发到死信队列中,消息被拒绝（Basic.Reject/Basic.Nack），并且该消息不能重新入队,消息过期；队列达到最大长度。

### 队列相关属性设置

| 属性      | 备注                                                         |
| --------- | ------------------------------------------------------------ |
| TTL       | 消息在队列中的生存时间一旦超过设置的TTL值时，就会变成“死信”（Dead Message），消费者将无法再收到该消息<br />如果对队列本身设置TTL，队列在到达存活时间后会自动删除 |
| exclusive | 队列是否是排他的。                                           |
|           |                                                              |

## RabbitMQ中消息语义和顺序性

### 消息在生产端,服务端,消费端的保障

- **生产端对消息可靠性的保证:**
  - **事务机制:**能够解决消息发送方和RabbitMQ之间消息确认的问题，只有消息成功被RabbitMQ接收，事务才能提交成功，事务机制在一条消息发送之后会使**发送端阻塞**，以等待RabbitMQ的回应，之后才能继续发送下一条消息，采用事务机制实现会严重降低RabbitMQ的消息吞吐量。
  - **confirm模式**，消息都会被指派一个**唯一的ID**（从1开始），一旦消息被投递到所有匹配的队列之后，RabbitMQ就会发送一个确认（Basic.Ack）给生产者（包含消息的唯一ID），这就使得生产者知晓消息已经正确到达了目的地了。如果消息和队列**是持久化的**，那么确认消息会在消息**写入磁盘之后**发出。RabbitMQ回传给生产者的确认消息中的deliveryTag包含了确认消息的序号，此外RabbitMQ也可以设置channel.basicAck方法中的multiple参数，表示到这个序号之前的所有消息都已经得到了处理。发送方确认机制**最大的好处在于它是异步**的
  - **异步confirm方法：**提供一个回调方法，服务端确认了一条或者多条消息后客户端会回调这个方法进行处理。
  - **批量confirm方法：**每发送一批消息后，调用channel.waitForConfirms方法，等待服务器的确认返回。
- **RabbitMQ服务端的保障**
  - 对交换器,队列,消息做持久性保障
- **消费端**
  -  消费端关闭自动应答，设置手动应答。
  - 利用数据库,redis，唯一性算法保障消息的唯一性
- **参考文档**
  - [史上最简单的RabbitMQ教程 | 第三篇： RabbitMQ高级特性之保证消息可靠性投递和消费](https://www.cnblogs.com/dc-earl/articles/11176603.html)

### RabbitMQ能否保障消息的顺序性,哪些场景下会出现消息乱序的情况

​	RabbitMq不能保障消息的顺序性

1. **生产者使用了事务机制**，在发送消息之后遇到异常进行了事务回滚，那么需要重新补偿发送这条消息，如果补偿发送是在另一个线程实现的，那么消息在生产者这个源头就出现了错序。同样，如果启用publisher confirm时，在发生超时、中断，又或者是收到RabbitMQ的Basic.Nack命令时，那么同样需要补偿发送，结果与事务机制一样会错序.
2. 消息设置了优先级，那么消费者消费到的消息也必然不是顺序性的。

## RabbitMQ 常用命令

### 插件命令

| 命令                                         | 说明                        |
| -------------------------------------------- | --------------------------- |
| rabbitmq-plugins enable rabbitmq_management  | 开启RabbitMQ managmenet插件 |
| rabbitmq-plugins list                        |                             |
| rabbitmq-plugins disable rabbitmq_management |                             |

### 应用管理命令

| 命令                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| **rabbitmqctl stop [pid_file]**                              | 用于停止运行RabbitMQ的Erlang虚拟机和RabbitMQ服务应用rabbitmq-plugins list |
| **rabbitmqctl shutdown**                                     | 用于停止运行RabbitMQ的Erlang虚拟机和RabbitMQ服务应用。rabbitmq-plugins disable rabbitmq_management |
| **rabbitmqctl stop_app**                                     | 停止RabbitMQ服务应用，但是Erlang虚拟机还是处于运行状态。     |
| **rabbitmqctl start_app**                                    |                                                              |
| **rabbitmqctl reset**                                        | 将RabbitMQ节点重置还原到最初状态。包括从原来所在的集群中删除此节点，从管理数据库中删除所有的配置数据，如已配置的用户、vhost等，以及删除所有的持久化消息。执行rabbitmqctl reset命令前必须停止RabbitMQ应用（比如先执行rabbitmqctl stop_app）。 |
| **rabbitmqctl force_reset**                                  | 强制将RabbitMQ节点重置还原到最初状态。不同于rabbitmqctl reset命令，rabbitmqctl force_reset命令不论当前管理数据库的状态和集群配置是什么，都会无条件地重置节点。它只能在数据库或集群配置已损坏的情况下使用。 |
| **rabbitmqctl list_queues [-p vhost] [queueinfoitem ...]**   | 服务器状态的查询会返回一个以制表符分隔的列表                 |
| **rabbitmqctl list_exchanges [-p vhost] [exchangeinfoitem ...]** | 查询交换器信息                                               |
| **rabbitmqctl list_bindings [-p vhost] [bindinginfoitem ...]** | 获取绑定key的信息                                            |
| **rabbitmqctl list_connections [connectioninfoitem ...]**    | 获取TCP连接信息                                              |
| **rabbitmqctl list_channels [channelinfoitem ...]**          | 获取连接信道信息                                             |
| **rabbitmqctl list_consumers [-p vhost]**                    | 获取消费者信息                                               |
| **rabbitmqctl status**                                       | 获取server的状态                                             |
| **rabbitmqctl node_health_check**                            | 获取节点健康检查                                             |
| **rabbitmqctl report**                                       | 服务器状态报告生成                                           |

### 集群管理

| 命令                                                 | 说明                                                         |
| ---------------------------------------------------- | ------------------------------------------------------------ |
| **rabbitmqctl join_cluster {cluster_node} [--ram]**  | 将节点加入指定集群中。在这个命令执行前需要停止RabbitMQ应用并重置节点。 |
| **rabbitmqctl cluster_status**                       | 显示集群的状态                                               |
| **rabbitmqctl change_cluster_node_type {disc，ram}** | 修改集群节点的类型                                           |
| **rabbitmqctl forget_cluster_node [--offline]**      | 节点下线                                                     |
| **rabbitmqctl update_cluster_nodes {clusternode}**   |                                                              |
| **rabbitmqctl set_cluster_name {name}**              |                                                              |