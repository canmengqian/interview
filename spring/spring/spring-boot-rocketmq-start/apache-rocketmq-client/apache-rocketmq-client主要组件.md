[TOC]



# 主要组件分类

| 组件名     | 包名      |      |
| ---------- | --------- | ---- |
| 生产者组件 | producer  |      |
| 消费者组件 | consumer  |      |
| admin管理  | admin     |      |
| 跟踪组件   | trace     |      |
| 容错组件   | latency   |      |
| 状态组件   | status    |      |
| 钩子组件   | hook      |      |
| 通用组件   | common    |      |
| 异常组件   | exception |      |



# 组件

## 基础操作

1.  ClientConfig
2.  MQHelper
3.  QueryResult
4.  Validators

## 生产者组件 

### 生产者接口  MQProducer

1.   默认生产者: DefaultMQProducer
   1. 基于事务的生产者: TransactionMQProducer

### 消息队列选择器  MessageQueueSelector

1.  随机模式: SelectMessageQueueByRandom
2. hash模式: SelectMessageQueueByHash
3.  MachineRoom: SelectMessageQueueByMachineRoom

### 发送结果和状态

1.  SendResult
   1.  TransactionSendResult
2.  SendStatus

### 事务

1.  LocalTransactionState
2.  事务监听器:TransactionListener

## 消费者组件

### 消费者接口MQConsumer

1.  拉模式消费者: MQPullConsumer
   1.  DefaultMQPullConsumer
2.   推模式消费者:  MQPushConsumer
   1.  DefaultMQPushConsumer
3.  轻量级拉取消费者: LitePullConsumer
   1.  DefaultLitePullConsumer
4. MQ定时任务: MQPullConsumerScheduleService
5. 并发上下文: ConsumeConcurrentlyContext
6. 消费顺序上下文: ConsumeOrderlyContext
7. 消息选择器: MessageSelector

### 消息监听器 MessageListener

1.  并发消息监听器: MessageListenerConcurrently
2.  有序消息监听器: MessageListenerOrderly
3.  MessageQueueListener

### 偏移量  OffsetStore

1.  RemoteBrokerOffsetStore
2.  LocalFileOffsetStore

### 枚举

1. 并发状态: ConsumeConcurrentlyStatus
2. 消费有序状态: ConsumeOrderlyStatus
3. 消费返回类型: ConsumeReturnType
4. 读取偏移量状态: ReadOffsetType
5. 拉取状态: PullStatus
6. 拉取结果对象: PullResult

### 消息队列分配策略 AllocateMessageQueueStrategy

1.   循环均分: AllocateMessageQueueAveragelyByCircle
2.  一致性hash: AllocateMessageQueueConsistentHash
3. 根据网络机房分配: AllocateMessageQueueByMachineRoom
4. 由配置分配: AllocateMessageQueueByConfig
5. 平均分配: AllocateMessageQueueAveragely
6. 机房就近原则: AllocateMachineRoomNearby

## 追踪组件

### TraceDispatcher

1.   AsyncTraceDispatcher

### 追踪服务

1.  ConsumeMessageHook
   1.  ConsumeMessageOpenTracingHookImpl
   2.  ConsumeMessageTraceHookImpl
2.  EndTransactionHook
   1.  EndTransactionOpenTracingHookImpl
   2.  EndTransactionTraceHookImpl
3.  SendMessageHook
   1.  SendMessageOpenTracingHookImpl
   2.  SendMessageTraceHookImpl
4.  CheckForbiddenHook
5.  FilterMessageHook

### 追踪上下文

1.   CheckForbiddenContext
2.  SendMessageContext
3.  FilterMessageContext
4.  TraceContext

### 枚举类型

1.  TraceDispatcherType
2.  TraceType

## 异常组件

1. 请求超时异常:  RequestTimeoutException
2. 客户端异常: MQClientException
3. 服务端异常: MQBrokerException

## 容错组件

1.  LatencyFaultTolerance
   1.  LatencyFaultToleranceImpl
2.  MQFaultStrategy

## 状态组件

1.  ConsumerStatsManager

