# 基本操作

1.  RocketMQTemplate

# 注解

1. 消费者扩展配置 @ExtRocketMQConsumerConfiguration
2. 模板扩展配置 @ExtRocketMQTemplateConfiguration
3. 事务监听器 @RocketMQTransactionListener
4. 消息监听器 @RocketMQMessageListener

# 枚举类

1. 选择器模式: SelectorType
2. 消息模式: MessageModel
3. 消费模式: ConsumeMode
4. 本地事务状态: RocketMQLocalTransactionState

# 监听器

1.  RocketMQListener
2.  回复监听器: RocketMQReplyListener
3. 本地事务监听器: RocketMQLocalTransactionListener
4. 推模式消费者监听器 : RocketMQPushConsumerLifecycleListener

# 自动配置类

# 支持工具

1.  监听器容器接口:RocketMQListenerContainer
   1.  DefaultRocketMQListenerContainer
2.  RocketMQConsumerLifecycleListener
3.  消息转换器: RocketMQMessageConverter
4. 消息头: RocketMQHeaders
5.  队列工具类: RocketMQUtil

