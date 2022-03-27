# 缓冲区Buffer

| 类                                                           | 描述                                         |
| :----------------------------------------------------------- | :------------------------------------------- |
| [Buffer](https://www.apiref.com/java11-zh/java.base/java/nio/Buffer.html) | 用于特定基元类型的数据的容器。               |
| [ByteBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/ByteBuffer.html) | 一个字节缓冲区。                             |
| [ByteOrder](https://www.apiref.com/java11-zh/java.base/java/nio/ByteOrder.html) | 字节顺序的类型安全枚举。                     |
| [CharBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/CharBuffer.html) | 一个char缓冲区。                             |
| [DoubleBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/DoubleBuffer.html) | 双缓冲。                                     |
| [FloatBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/FloatBuffer.html) | 浮动缓冲区。                                 |
| [IntBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/IntBuffer.html) | 一个int缓冲区。                              |
| [LongBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/LongBuffer.html) | 一个长缓冲区。                               |
| [MappedByteBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/MappedByteBuffer.html) | 直接字节缓冲区，其内容是文件的内存映射区域。 |
| [ShortBuffer](https://www.apiref.com/java11-zh/java.base/java/nio/ShortBuffer.html) | 一个短缓冲区。                               |

# 管道

| 接口                                                         | 描述                                              |
| :----------------------------------------------------------- | :------------------------------------------------ |
| [AsynchronousByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/AsynchronousByteChannel.html) | 异步读写字节的通道。                              |
| [AsynchronousChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/AsynchronousChannel.html) | 支持异步I / O操作的通道。                         |
| [ByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/ByteChannel.html) | 一个可以读写字节的通道。                          |
| [Channel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Channel.html) | I / O操作的关系。                                 |
| [CompletionHandler](https://www.apiref.com/java11-zh/java.base/java/nio/channels/CompletionHandler.html)<V,A> | 用于消耗异步I / O操作结果的处理程序。             |
| [GatheringByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/GatheringByteChannel.html) | 一个可以从一系列缓冲区写入字节的通道。            |
| [InterruptibleChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/InterruptibleChannel.html) | 可以异步关闭和中断的通道。                        |
| [MulticastChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/MulticastChannel.html) | 支持Internet协议（IP）多播的网络通道。            |
| [NetworkChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/NetworkChannel.html) | 到网络套接字的通道。                              |
| [ReadableByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/ReadableByteChannel.html) | 一个可以读取字节的通道。                          |
| [ScatteringByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/ScatteringByteChannel.html) | 一个可以将字节读入缓冲区序列的通道。              |
| [SeekableByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/SeekableByteChannel.html) | 一个字节通道，用于维护当前 *位置*并允许更改位置。 |
| [WritableByteChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/WritableByteChannel.html) | 可以写入字节的通道。                              |

| [AsynchronousChannelGroup](https://www.apiref.com/java11-zh/java.base/java/nio/channels/AsynchronousChannelGroup.html) | 用于资源共享的一组异步通道。                                 |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| [AsynchronousFileChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/AsynchronousFileChannel.html) | 用于读取，写入和操作文件的异步通道。                         |
| [AsynchronousServerSocketChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/AsynchronousServerSocketChannel.html) | 面向流的侦听套接字的异步通道。                               |
| [AsynchronousSocketChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/AsynchronousSocketChannel.html) | 面向流的连接套接字的异步通道。                               |
| [Channels](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Channels.html) | 通道和流的实用方法。                                         |
| [DatagramChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/DatagramChannel.html) | 面向数据报的套接字的可选通道。                               |
| [FileChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/FileChannel.html) | 用于读取，写入，映射和操作文件的通道。                       |
| [FileChannel.MapMode](https://www.apiref.com/java11-zh/java.base/java/nio/channels/FileChannel.MapMode.html) | 文件映射模式的类型安全枚举。                                 |
| [FileLock](https://www.apiref.com/java11-zh/java.base/java/nio/channels/FileLock.html) | 表示文件区域锁定的标记。                                     |
| [MembershipKey](https://www.apiref.com/java11-zh/java.base/java/nio/channels/MembershipKey.html) | 表示Internet协议（IP）多播组成员身份的令牌。                 |
| [Pipe](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.html) | 一对实现单向管道的通道。                                     |
| [Pipe.SinkChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.SinkChannel.html) | 表示[`Pipe`](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.html)的可写端的[通道](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.html) 。 |
| [Pipe.SourceChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.SourceChannel.html) | 表示[`Pipe`](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.html)可读端的[通道](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Pipe.html) 。 |
| [SelectableChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/SelectableChannel.html) | 可通过[`Selector`](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Selector.html)多路复用的[通道](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Selector.html) 。 |
| [SelectionKey](https://www.apiref.com/java11-zh/java.base/java/nio/channels/SelectionKey.html) | 表示[`SelectableChannel`](https://www.apiref.com/java11-zh/java.base/java/nio/channels/SelectableChannel.html)与[`Selector`](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Selector.html)注册的令牌。 |
| [Selector](https://www.apiref.com/java11-zh/java.base/java/nio/channels/Selector.html) | [`SelectableChannel`](https://www.apiref.com/java11-zh/java.base/java/nio/channels/SelectableChannel.html)对象的多路复用器。 |
| [ServerSocketChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/ServerSocketChannel.html) | 面向流的侦听套接字的可选通道。                               |
| [SocketChannel](https://www.apiref.com/java11-zh/java.base/java/nio/channels/SocketChannel.html) | 用于面向流的连接套接字的可选通道。                           |

# 编码

| 类                                                           | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Charset](https://www.apiref.com/java11-zh/java.base/java/nio/charset/Charset.html) | 十六位Unicode [code units的](https://www.apiref.com/java11-zh/java.base/java/lang/Character.html#unicode)序列与字节序列之间的命名映射。 |
| [CharsetDecoder](https://www.apiref.com/java11-zh/java.base/java/nio/charset/CharsetDecoder.html) | 一种引擎，可以将特定字符集中的字节序列转换为16位Unicode字符序列。 |
| [CharsetEncoder](https://www.apiref.com/java11-zh/java.base/java/nio/charset/CharsetEncoder.html) | 一种引擎，可以将16位Unicode字符序列转换为特定字符集中的字节序列。 |
| [CoderResult](https://www.apiref.com/java11-zh/java.base/java/nio/charset/CoderResult.html) | 编码器的结果状态的描述。                                     |
| [CodingErrorAction](https://www.apiref.com/java11-zh/java.base/java/nio/charset/CodingErrorAction.html) | 编码错误操作的类型安全枚举。                                 |
| [StandardCharsets](https://www.apiref.com/java11-zh/java.base/java/nio/charset/StandardCharsets.html) | 标准[`Charsets`的](https://www.apiref.com/java11-zh/java.base/java/nio/charset/Charset.html)常量定义。 |

# 文件处理



| 接口                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| **文件操作**                                                 |                                                              |
| [CopyOption](https://www.apiref.com/java11-zh/java.base/java/nio/file/CopyOption.html) | 配置如何复制或移动文件的对象。                               |
| **目录和文件**                                               |                                                              |
| [DirectoryStream](https://www.apiref.com/java11-zh/java.base/java/nio/file/DirectoryStream.html)<T> | 迭代目录中条目的对象。                                       |
| [DirectoryStream.Filter](https://www.apiref.com/java11-zh/java.base/java/nio/file/DirectoryStream.Filter.html)<T> | 由对象实现的接口，用于决定是应该接受还是过滤目录条目。       |
| [FileVisitor](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileVisitor.html)<T> | 文件的访问者。                                               |
| [OpenOption](https://www.apiref.com/java11-zh/java.base/java/nio/file/OpenOption.html) | 配置如何打开或创建文件的对象。                               |
| [Path](https://www.apiref.com/java11-zh/java.base/java/nio/file/Path.html) | 可用于在文件系统中查找文件的对象。                           |
| [PathMatcher](https://www.apiref.com/java11-zh/java.base/java/nio/file/PathMatcher.html) | 由在路径上执行匹配操作的对象实现的接口。                     |
| [SecureDirectoryStream](https://www.apiref.com/java11-zh/java.base/java/nio/file/SecureDirectoryStream.html)<T> | `DirectoryStream` ，用于定义相对于打开目录的文件的操作。     |
| **监测器**                                                   |                                                              |
| [Watchable](https://www.apiref.com/java11-zh/java.base/java/nio/file/Watchable.html) | 可以向监视服务注册的对象，以便可以 *监视*其更改和事件。      |
| [WatchEvent](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchEvent.html)<T> | 使用[`WatchService`](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchService.html)注册的对象的事件或重复事件。 |
| [WatchEvent.Kind](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchEvent.Kind.html)<T> | 一种事件类型，用于识别目的。                                 |
| [WatchEvent.Modifier](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchEvent.Modifier.html) | 一个事件修饰符，用于限定[`Watchable`](https://www.apiref.com/java11-zh/java.base/java/nio/file/Watchable.html)在[`WatchService`](https://www.apiref.com/java11-zh/java.base/java/nio/file/Watchable.html)中的注册[方式](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchService.html) 。 |
| [WatchKey](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchKey.html) | 表示使用[`WatchService`](https://www.apiref.com/java11-zh/java.base/java/nio/file/Watchable.html)注册[`watchable`](https://www.apiref.com/java11-zh/java.base/java/nio/file/Watchable.html)对象的[标记](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchService.html) 。 |
| [WatchService](https://www.apiref.com/java11-zh/java.base/java/nio/file/WatchService.html) | 手表服务， *手表*已注册的对象的变化和事件。                  |
| **文件处理**                                                 |                                                              |
| [Files](https://www.apiref.com/java11-zh/java.base/java/nio/file/Files.html) | 此类仅包含对文件，目录或其他类型文件进行操作的静态方法。     |
| [FileStore](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileStore.html) | 存储文件。                                                   |
| [FileSystem](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileSystem.html) | 提供文件系统的接口，是用于访问文件系统中的文件和其他对象的对象的工厂。 |
| [FileSystems](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileSystems.html) | 文件系统的工厂方法。                                         |
| [LinkPermission](https://www.apiref.com/java11-zh/java.base/java/nio/file/LinkPermission.html) | 用于链接创建操作的 `Permission`类。                          |
| [Paths](https://www.apiref.com/java11-zh/java.base/java/nio/file/Paths.html) | 此类仅[包含](https://www.apiref.com/java11-zh/java.base/java/nio/file/Path.html)通过转换路径字符串或[`URI`](https://www.apiref.com/java11-zh/java.base/java/net/URI.html)返回[`Path`](https://www.apiref.com/java11-zh/java.base/java/nio/file/Path.html)的静态方法。 |
| [SimpleFileVisitor](https://www.apiref.com/java11-zh/java.base/java/nio/file/SimpleFileVisitor.html)<T> | 具有默认行为的文件的简单访问者，可访问所有文件并重新抛出I / O错误。 |
| [StandardWatchEventKinds](https://www.apiref.com/java11-zh/java.base/java/nio/file/StandardWatchEventKinds.html) | 定义 *标准*事件种类。                                        |
| **文件枚举类**                                               |                                                              |
| [AccessMode](https://www.apiref.com/java11-zh/java.base/java/nio/file/AccessMode.html) | 定义用于测试文件可访问性的访问模式。                         |
| [FileVisitOption](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileVisitOption.html) | 定义文件树遍历选项。                                         |
| [FileVisitResult](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileVisitResult.html) | 结果类型为[`FileVisitor`](https://www.apiref.com/java11-zh/java.base/java/nio/file/FileVisitor.html) 。 |
| [LinkOption](https://www.apiref.com/java11-zh/java.base/java/nio/file/LinkOption.html) | 定义如何处理符号链接的选项。                                 |
| [StandardCopyOption](https://www.apiref.com/java11-zh/java.base/java/nio/file/StandardCopyOption.html) | 定义标准副本选项。                                           |
| [StandardOpenOption](https://www.apiref.com/java11-zh/java.base/java/nio/file/StandardOpenOption.html) |                                                              |