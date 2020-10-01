# Netty知识点

[TOC]

## Netty用到的设计模式

- 责任链
- 适配器

## Netty重要的组件

| 组件名                                | 描述                                                         |      |
| ------------------------------------- | ------------------------------------------------------------ | ---- |
| **字节容器**                          |                                                              |      |
| ByteBuf                               |                                                              |      |
| ByteProcessor                         |                                                              |      |
| ByteBufHolder                         |                                                              |      |
| **编码和解码器**                      | 包含基于json,xml,protobuf,String的编码和反编码,包含加密和压缩算法 |      |
| ByteToMessageDecoder                  |                                                              |      |
| ReplayingDecoder                      |                                                              |      |
| MessageToMessageDecoder               |                                                              |      |
| MessageToByteEncoder                  |                                                              |      |
| MessageToMessageEncoder               |                                                              |      |
| ObjectDecoder<br />ObjectEncoder      |                                                              |      |
| MarshallingDecoder MarshallingEncoder | 适用于使用 JBoss Marshalling 的节点                          |      |
| ProtobufDecoder<br />ProtobufEncoder  |                                                              |      |
| NameResolver                          |                                                              |      |
| AddressResolver                       |                                                              |      |
|                                       |                                                              |      |
| **事件循环组件**                      |                                                              |      |
| EventLoop                             |                                                              |      |
| EventLoopGroup                        |                                                              |      |
| EventExecutorGroup                    |                                                              |      |
| EventExecutor                         |                                                              |      |
| **通道类组件**                        |                                                              |      |
| ChannelHandlerContext                 |                                                              |      |
| ChannelPipeline                       |                                                              |      |
| ChannelInitializer                    |                                                              |      |
| ChannelConfig                         |                                                              |      |
| ChannelHandler                        |                                                              |      |
| ChannelHandlerAdapter                 |                                                              |      |
| ChannelFuture                         |                                                              |      |
| ChannelFutureListener                 |                                                              |      |
| ChannelOutboundHandler                |                                                              |      |
| ChannelPromise                        |                                                              |      |
| ChannelOption                         |                                                              |      |
| **引导类组件**                        | 一个进程绑定到某个指定的端口                                 |      |
| AbstractBootstrap                     |                                                              |      |
| Bootstrap                             | 客户端                                                       |      |
| ServerBootstrap                       | 服务器                                                       |      |
|                                       |                                                              |      |
| **工具类**                            |                                                              |      |
| ResourceLeakDetector                  | 内存泄露探测器                                               |      |
| ReferenceCountUtil                    |                                                              |      |

## Channel、 EventLoop、 Thread 以及 EventLoopGroup 之间的关系  

1. 一个 EventLoopGroup 包含一个或者多个 EventLoop；
2. 一个 EventLoop 在它的生命周期内只和一个 Thread 绑定，所有由 EventLoop 处理的 I/O 事件都将在它专有的 Thread 上被处理
3. 一个 Channel 在它的生命周期内只注册于一个 EventLoop；一个 EventLoop 可能会被分配给一个或多个 Channel。

## 客户端（Bootstrap）和ServerBootstrap的区别  

## Netty所提供的IO模型？

### ChannelPipeline的用途？

- 移除或者替换ChannelPipeline  中的ChannelHandler  

### JDK调度线程池的缺陷和Netty如何使用调度？