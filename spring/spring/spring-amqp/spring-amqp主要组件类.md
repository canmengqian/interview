[TOC]



# 核心

## 队列定义

1.  Declarable
    1.  抽象声明接口: AbstractDeclarable
        1.  队列 Queue
            1.  匿名队列:AnonymousQueue
        2. 绑定 Binding
    2.  交换器: Exchange
        1.  抽象交换器: AbstractExchange
            1.  自定义交换器: CustomExchange
            2.  TopicExchange
            3.  FanoutExchange
            4.  DirectExchange
            5.  HeadersExchange
2. 消息地址: Address
3. 抽象 建造器: AbstractBuilder
    1.   队列建造器: QueueBuilder
    2.  交换器建造器: ExchangeBuilder
    3.  BindingBuilder
4. 队列信息: QueueInformation
5. 自定义声明接口:DeclarableCustomizer
6. 异步amqp模板: AsyncAmqpTemplate

## 命名策略 NamingStrategy

1. base64策略: Base64UrlNamingStrategy
2. UUID策略: UUIDNamingStrategy

## 消息

1.  消息对象: Message
2. 消息构建支持器:  MessageBuilderSupport
    1.   消息构建器: MessageBuilder
    2.  消息属性构建器:MessagePropertiesBuilder
3.  消息监听器: MessageListener
    1.  批量消息监听器: BatchMessageListener
4.  接收和回复消息回调接口: ReceiveAndReplyCallback
    1.   ReceiveAndReplyMessageCallback
5. 消息后置处理器: MessagePostProcessor
6. 消息投递模式: MessageDeliveryMode
7. ACK模式: AcknowledgeMode
8. 返回消息对象: ReturnedMessage

## 杂类

1. 消息属性: MessageProperties
2. 交换器类型: ExchangeTypes

# 工具类

1.  序列化工具类: SerializationUtils
2.  map构建器: MapBuilder
3.  JavaUtils
4. 属性测试工具  TestUtils

# Amqp头部消息

## 头部映射器 AmqpHeaderMapper

1.   SimpleAmqpHeaderMapper
2.  AmqpMessageHeaderAccessor
3.  AmqpHeaders

## 消息转换器

1.  