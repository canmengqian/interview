# 组件

## 远程服务

1.  RemotingService
   1.  远程客户端: RemotingClient
   2. 远程服务端: RemotingServer
   3.  服务线程: ServiceThread

## 异常体系

1.  远程异常: RemotingException
   1.   RemotingTooMuchRequestException
   2.  RemotingConnectException
   3.  RemotingTimeoutException
   4.  RemotingCommandException
   5.  RemotingSendRequestException

## 工具类

1.  SemaphoreReleaseOnlyOnce
2. 序列化工具类: SerializeType
3. 远程工具类: RemotingUtil
4. 远程帮助者： RemotingHelper
5. 远程命令行类型: RemotingCommandType
6. 远程命令行: RemotingCommand
7. 远程响应码: RemotingSysResponseCode
8.  语言类型编码: LanguageCode
9.  TlsMode