[TOC]



# 内/外部管道调用器

1.  ChannelInboundInvoker
   1. 管道流 ChannelPipeline
      1.  DefaultChannelPipeline
2. 外部管道调用器: ChannelOutboundInvoker
   1.  管道处理器上下文 ChannelHandlerContext
      1.  AbstractChannelHandlerContext
      2.  DefaultChannelHandlerContext
3.  Channel

# 管道接口 Channel

1. 服务器管道: ServerChannel
   1.   抽象服务器管道:AbstractServerChannel
2.  AbstractChannel
3. 管道工厂: ChannelFactory
   1.  基于反射的管道工厂: ReflectiveChannelFactory
4. 管道初始化器: ChannelInitializer

# 管道处理器 ChannelHandler

1.  管道处理器适配器: ChannelHandlerAdapter
   1.  ChannelInboundHandlerAdapter
      1.  简单内部绑定处理器 SimpleChannelInboundHandler
      2.  SimpleUserEventChannelHandler
      3. 双工管道处理器: ChannelDuplexHandler
         1.  CombinedChannelDuplexHandler
2.   ChannelInboundHandler
3.   ChannelOutboundHandler
   1.   ChannelOutboundHandlerAdapter

#  ChannelFuture

#  ChannelFutureListener监听器

# 事件循环组 EventLoopGroup

# 接收字节缓冲区分配器

# 选择器策略工厂

# 选择器策略

# 杂类

