[TOC]



# 客户端常用包

## RocketMq-client

### 消费者:  org.apache.rocketmq.client.consumer

#### :family:MQConsumer

|                |          |      |
| -------------- | -------- | ---- |
| MQPullConsumer | 消息拉取 |      |
| MQPushConsumer | 消息推送 |      |
|                |          |      |

#### :family:AllocateMessageQueueStrategy: 消费者之间消息分配的策略算法

|                                              |                              |                                                              |
| -------------------------------------------- | ---------------------------- | ------------------------------------------------------------ |
| :baby:AllocateMessageQueueAveragely          | 平均哈希队列算法             |                                                              |
| :baby: AllocateMachineRoomNearby             | 机房就近优先级的分配策略代理 | 一种基于机房近侧优先级的分配策略代理。 可以指定实际的分配策略。 如果机房中存在任何消费者，则部署在同一台机器上的代理的消息队列应该只分配给那些消费者。 否则，这些消息队列可以被所有消费者共享，因为没有活着的消费者来垄断它们。 |
| :baby: AllocateMessageQueueAveragelyByCircle | Hash轮询方法                 |                                                              |
| :baby:AllocateMessageQueueByMachineRoom      |                              |                                                              |
| :baby:AllocateMessageQueueConsistentHash     | 一致性Hash                   |                                                              |

#### :family:MessageListener：用于接收异步传递的消息

|                             |      |      |
| --------------------------- | ---- | ---- |
| MessageListenerConcurrently |      |      |
| MessageListenerOrderly      |      |      |

#### :family:OffsetStore: 偏移量存储接口

|                         |                  |      |
| ----------------------- | ---------------- | ---- |
| LocalFileOffsetStore    | 本地文件存储服务 |      |
| RemoteBrokerOffsetStore | 远程服务器存储   |      |
|                         |                  |      |

#### ConsumeConcurrentlyStatus

#### ReadOffsetType:偏移量读取类型

#### MQPullConsumerScheduleService:为pull类型消费者做服务编排

#### ConsumeReturnType





#### 

#### 



