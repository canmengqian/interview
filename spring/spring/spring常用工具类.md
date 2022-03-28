# Spring常用工具类

1. Backof 退避算法
2. spring 比较器 
3. jdk id 生成器 AlternativeJdkIdGenerator 
4. 断言工具  Assert
5. 自动可填充List  AutoPopulatingList
6. Base64编码解码工具 Base64Utils
7. 类工具 ClassUtils
    1. 用于获取类的Method属性,修饰符，类名称等信息
8. 集合工具 CollectionUtils
    1. 用于判断集合是否为空,实例化集合,转换为数组,元素查找
9. 并发控制工具类 ConcurrencyThrottleSupport
    1. [ring控制并发数的工具类ConcurrencyThrottleSupport和ConcurrencyThrottleInterceptor](https://www.cnblogs.com/duanxz/p/9435873.html)
10. 摘要算法 DigestUtils
    1. 包含hex ,md5
11. 并发LRU 缓存ConcurrentLruCache
12. 自定义线程创建器CustomizableThreadCreator
13. 属性持久化器 DefaultPropertiesPersister
14. 文件拷贝工具 FileCopyUtils
15. 文件系统工具 FileSystemUtils
    1. 递归拷贝,递归删除
16. 实例对象过滤器 InstanceFilter
17. 方法调用器 MethodInvoker
18. 正则匹配工具PatternMatchUtils
19. LinkedCaseInsensitiveMap key值不区分大小写的LinkedMap 
20. ReflectionUtils 反映常用工具方法. 有 findField, setField, getField, findMethod, invokeMethod等有用的方法
21. StopWatch 一个很好的用于记录执行时间的工具类
22. WeakReferenceMonitor 弱引用的监控 
23. TypeUtils 用于类型相容的判断. isAssignable
24. socket 工具: SocketUtils
    1. 查找可用的TCP/UDP端口
25. 字符串工具 StringUtils

## web工具类

1. web工具类 WebUtils
    1. 清楚,暴漏错误请求错误属性
    2. 查找请求参数
    3. 获取cookie和session ,获取sessionId
    4. 获取端口和真实请求路径,获取临时路径
    5. 判断是否同源

