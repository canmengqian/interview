[TOC]

# 核心

1. RabbitMq基本操作接口: RabbitOperations

    1.  RabbitTemplate
    2.  BatchingRabbitTemplate

2. Rabbitmq消息操作： RabbitMessageOperations

    1.   RabbitMessagingTemplate

3.  RabbitAdmin

    # 常用注解



1.  @RabbitListeners
2.  @RabbitListener
3.  @RabbitHandler
4.  @EnableRabbit
5.  @QueueBinding
6.  @ Exchange
7.  @Argument
8.  @Queue



# 批处理

1.  BatchingStrategy 批处理策略
    1.  SimpleBatchingStrategy
2.  MessageBatch

# 配置

1.  RabbitListenerConfigurer  监听器配置类
2.  RabbitBootstrapConfiguration

# 解析器

1.  抽象交换器解析器:AbstractExchangeParser
    1.  TopicExchangeParser
    2.  HeadersExchangeParser
    3.  DirectExchangeParser
    4.  FanoutExchangeParser
2. 其他解析器
    1.  AdminParser
    2.  队列解析器: QueueParser
    3.  模板解析器: TemplateParser
    4.  队列参数解析器: QueueArgumentsParser
    5.  监听器容器解析器: ListenerContainerParser
    6. 连接工厂解析器: ConnectionFactoryParser



# 连接器

1.  连接工厂 ConnectionFactory
    1.  AbstractConnectionFactory 
        1.  PooledChannelConnectionFactory 管道池连接工厂
        2.  ThreadChannelConnectionFactory 线程管道连接工厂
        3.  CachingConnectionFactory 缓存连接工厂
2.  路由连接工厂 RoutingConnectionFactory
    1.  AbstractRoutingConnectionFactory
        1.  简单路由连接工厂 SimpleRoutingConnectionFactory 
    2.  LocalizedQueueConnectionFactory
3.  连接工厂上下文包装器 ConnectionFactoryContextWrapper
4.  管道连接接口 Connection
    1.   SimpleConnection
    2.  ConnectionProxy
5.  管道连接监听器  ConnectionListener
    1.  CompositeConnectionListener
6. 连接名称策略 : ConnectionNameStrategy
    1. 基于k-v属性的连接名称策略 ：SimplePropertyValueConnectionNameStrategy
7.  发布回调管道 PublisherCallbackChannel
    1.   PublisherCallbackChannelImpl

# 资源处理

1.  RabbitResourceHolder
2.  SimpleResourceHolder

# 事件

1. 连接非阻塞事件 : ConnectionUnblockedEvent
2. 连接阻塞事件 : ConnectionBlockedEvent
3.  RabbitAdminEvent
    1.  DeclarationExceptionEvent
4.  服务器事件:BrokerEvent
    1.  BrokerEventListener

# 监听器

# 重试机制

1.  消息恢复接口 : MessageRecoverer
    1. 发布消息恢复器:RepublishMessageRecoverer 
        1.   RepublishMessageRecovererWithConfirms
    2. 批量消息恢复接口 MessageBatchRecoverer
    3. 拒绝并不再入队恢复器 RejectAndDontRequeueRecoverer
    4. 立即重入队恢复器： ImmediateRequeueMessageRecoverer
2.  消息key生成器: MessageKeyGenerator

# 支持工具

1.  消息属性转换器接口:MessagePropertiesConverter
    1.  DefaultMessagePropertiesConverter
2. rabbit异常翻译器: RabbitExceptionTranslator
3.   活跃对象计数器: ActiveObjectCounter
4.   参数构建器: ArgumentBuilder
5.  交付对象: Delivery

# 事务

1.  RabbitTransactionManager

# 工具类

1.  连接工厂配置工具类 ConnectionFactoryConfigurationUtils
2.  连接工厂工具 ： ConnectionFactoryUtils
3.  rabbit监听配置工具：RabbitListenerConfigUtils
4.  命名空间工具类: NamespaceUtils
5.  RabbitNamespaceUtils
6.  RabbitUtils

