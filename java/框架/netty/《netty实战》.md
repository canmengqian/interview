[TOC]

# 引导Bootstrap

## Bootstrap

1.  用于客户端，连接到远程主机和端口，EventLoopGroup的数目：1

## ServerBootstrap

1.  用于服务器,绑定到一个本地端口，EventLoopGroup的数目：2，一个用来接收请求,一个用来处理请求

# Netty的核心组件

## Channel接口

- 基本的I/O操作（bind()、connect()、read()和write()）依赖于底层网络传输所提供的原语
- 创建Channel->创建EventLoopGroup->EventLoopGroup管理EventLoop,channel选择对应的EventLoop,EventLoop处理IO
- 每个Channel都将会被分配一个ChannelPipeline和ChannelConfig,hannelConfig包含了该Channel的所有配置设置，并且支持热更新

### Channel的生命周期

### ChannelHandler的生命周期

## EventLoop接口

-  EventLoop定义了Netty的核心抽象，用于处理连接的生命周期中所发生的事件

## EventLoopGroup

1. 一个EventLoopGroup包含一个或者多个EventLoop；
2. 一个EventLoop在它的生命周期内只和一个Thread绑定；所有由EventLoop处理的I/O事件都将在它专有的Thread上被处理；
3. 一个Channel在它的生命周期内只注册于一个EventLoop；一个EventLoop可能会被分配给一个或多个Channel。

## ChannelHandler接口

1. ChannelInboundHandler接收入站事件和数据，这些数据随后将会被你的应用程序的业务逻辑所处理。当你要给连接的客户端发送响应时，也可以从ChannelInboundHandler冲刷数据。应用程序的业务逻辑通常驻留在一个或者多个ChannelInboundHandler中
2. Netty以适配器类的形式提供了大量默认的ChannelHandler实现，其旨在简化应用程序处理逻辑的开发过程。
3. 将数据从一种格式转换为另一种格式，提供异常的通知,提供Channel变为活动的或者非活动的通知，提供当Channel注册到EventLoop或者从EventLoop注销时的通知

# 编码器和解码器

1. 对于入站数据，channelRead方法/事件已经被重写了。每个从入站Channel读取的消息，这个方法都将调用置解码器所提供的decode()方法，并将已解码的字节转发给ChannelPipeline中的下一个ChannelInboundHandler。

## 编码器

1. 将字节解码为消息——ByteToMessageDecoder和ReplayingDecoder；
2. 将一种消息类型解码为另一种——MessageToMessageDecoder。
3. LineBasedFrameDecoder
4. HttpObjectDecoder

## ByteBuf

1. 通过内置的复合缓冲区类型实现了透明的零拷贝 ,容量可以按需增长（类似于JDK的StringBuilder）\
2. 在读和写这两种模式之间切换不需要调用ByteBuffer的flip()方法,读和写使用了不同的索引
3. 读和写使用了不同的索引,支持池化