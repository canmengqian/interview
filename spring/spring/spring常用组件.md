[TOC]

# Bean模块

1. 接口 org.springframework.beans.factory.Aware

## Bean元数据和定义

1.  元数据属性访问器 BeanMetadataAttributeAccessor
2.  BeanMetadataElement
3.  BeanDefinitionHolder
4.  BeanDefinition
5.  BeanReference

## Bean生成

1.  SingletonBeanRegistry
2.  BeanDefinitionRegistry
3. FactoryBean
4. InitializingBean
5.  AliasRegistry
6.  BeanFactory
7.  ConfigurableBeanFactory
8.  HierarchicalBeanFactory
9.  AutowireCapableBeanFactory

## Bean实例化后置处理器

## 属性编辑器

1. java.beans.PropertyEditor
2.  PropertyEditorRegistry
3.  PropertyAccessor
4.  TypeConverter
5. BeanWrapper

# Core核心组件

## 编码与解码

1.  Encoder
2.  Decoder

## 类型转换

1.  ConversionService
2.  ConverterRegistry
3.  ConfigurableConversionService
4.  Converter
5.  ConverterFactory
6.  GenericConverter
7.  ConditionalConverter
8.  ConditionalGenericConverter

## 环境env

1.  Environment
2.  ConfigurableEnvironment
3.  ConfigurablePropertyResolver
4.  PropertySource
5.  MapPropertySource
6.  CompositePropertySource
7.  CommandLinePropertySource
8.  Profiles

IO流

1.  InputStreamSource
    1. 基于stream的资源
2.  Resource 
    1. 资源接口,包含byteArray,文件,url，classpath，文件系统，fileUrl等资源
3.  ContextResource
4.  WritableResource
5.  EncodedResource
    1. 可被编码的资源
6.  ResourceLoader
7.  DefaultResourceLoader
    1. 基于类路径资源加载器  ClassRelativeResourceLoader
    2. 基于文件系统加载器  FileSystemResourceLoader
8.  ResourcePatternResolver 基于正则的路径解析器

异步任务 Task



# 上下文模块Context

## 缓存组件

1. 缓存管理器   CacheManager
    1. 管理器类型
2. 缓存解析器
    1.  CacheResolver
3. 缓存基本操作
    1.  CacheOperationSource
    2.  SimpleValueWrapper
4. 缓存类型 
    1.  Cache
5. 缓存错误处理
    1.  CacheErrorHandler
6. 缓存配置器
    1.  CachingConfigurer
    2.  CacheManagementConfigUtils
7. 缓存key生成器
    1.  KeyGenerator
8. 缓存切面
    1.  AbstractCacheInvoker
9. 缓存上下文
    1.  CacheEvaluationContext
10. 缓存常用注解
    1.  @EnableCaching
    2.  @CacheConfig
    3.  @CacheEvict
    4.  @Cacheable
    5.  @Caching
    6.  @CachePut

## 上下文组件

## 格式化

1. 解析器 Parser
2. 打印器 Printer
3.  格式化器 Formatter
    1. 时间格式化器
    2. 货币格式化器
4. 注册器
    1.  FormatterRegistry
    2.  FormatterRegistrar
5. 工具类
    1.  DateTimeContextHolder
    2. 转换器 DateTimeConverters
    3.  DateTimeContext
    4.  DateTimeFormatterUtils
6. 注解类
    1.  NumberFormat
    2.  @DateTimeFormat

## 调度器

1.  计划任务执行器 SchedulingTaskExecutor
2.  并发任务执行器  ConcurrentTaskExecutor
3.  任务计划 TaskScheduler
4. 基于线程池的调度器和执行器  ThreadPoolTaskScheduler 、ThreadPoolTaskExecutor
5. 自定义线程工厂
6.  计划任务持有者
    1. 计划任务注册器
    2. 后置处理器
7. 工厂bean 
    1.  ForkJoinPoolFactoryBean
    2.  TaskExecutorFactoryBean
    3.  MethodInvokingRunnable
8. Cron表达式字段
    1.  CronField
9. 任务
    1. 间隔任务  IntervalTask
    2. cron表达式任务 TriggerTask
    3. 异步结果 AsyncResult
    4.  cron表达式 CronExpression
    5. 定时配置器 SchedulingConfigurer
10. 触发器
    1.  Trigger
    2.  CronTrigger
    3.  PeriodicTrigger
11. 触发器上下文
12. 异步任务配置器
13. 工具类
    1.  TaskUtils
    2.  ScheduledTask
    3.  TaskManagementConfigUtils
14. 注解类
    1. @Schedules
    2.  @Scheduled
    3. @EnableAsync
    4. @EnableScheduling
    5. @Async

## Bean验证

### 错误和验证结果

1.  Errors
2.  AbstractErrors
3.  BindingResult
4.  AbstractBindingResult
5.  ObjectError

### 绑定错误处理器

1.  BindingErrorProcessor

### 验证器

1.  Validator
2.  SmartValidator

### 消息解析器

1.  MessageCodesResolver
2.  MessageCodeFormatter

### 对象工厂、Bean后置处理器、拦截器

1.  SpringConstraintValidatorFactory
2.  方法验证后置处理器 MethodValidationPostProcessor
3.  Bean验证后置处理器 BeanValidationPostProcessor
4.  LocaleContextMessageInterpolator
5.  MethodValidationInterceptor

### 工具类

1.  ValidationAnnotationUtils
2.  ValidationUtils
3.  BindingResultUtils

### 注解类

1.  @Validated





# Spring事务

## 事务管理器

1.  TransactionManager
2.  响应式事务管理器 ReactiveTransactionManager
3.  平台事务管理器 PlatformTransactionManager
    1.  偏向回调事务 CallbackPreferringPlatformTransactionManager
    2.  资源事务 : ResourceTransactionManager
    3.  抽象平台事务: AbstractPlatformTransactionManager
4. 事务工厂 TransactionFactory
    1.  SimpleTransactionFactory

## 事务配置

## 事务定义

1.  TransactionDefinition
    1.  TransactionAttribute
    2.  ResourceTransactionDefinition
    3.  DelegatingTransactionDefinition
    4.  DefaultTransactionDefinition
    5.   TransactionOperations

## 事务状态

1.  事务保存点管理器 ： SavepointManager
2.  事务执行接口 TransactionExecution
3.  TransactionStatus
    1.  默认事务状态 : DefaultTransactionStatus
    2. 简单事务状态: SimpleTransactionStatus



## 上下文&监听器

## 事务异常

1.  TransactionException
    1.  无法创建事务异常 ： CannotCreateTransactionException
    2. 回滚异常 UnexpectedRollbackException
    3. 事务超时异常：TransactionTimedOutException
    4. 事务系统异常：TransactionSystemException
    5. 事务使用异常 TransactionUsageException
        1. 无效超时异常 ： InvalidTimeoutException
        2. 非法事务状态异常 ： IllegalTransactionStateException
        3. 无事务异常 ： NoTransactionException

## 杂项

## 

# Servlet

## Servlet

1.  Servlet
2.  ServletConfig
3.  GenericServlet
4.  HttpServlet

## 注册器

1.  Registration
2.  ServletRegistration
3.  FilterRegistration

## Http请求和响应

1.  ServletResponse
2.  HttpServletResponse
3.  HttpServletResponseWrapper
4.  ServletRequest
5.  HttpServletRequest
6.  HttpServletRequestWrapper
7.  RequestDispatcher

## 上下文

1.  AsyncContext
2.  ServletContext

## 事件

1.  ServletRequestEvent
2.  ServletContextEvent
3.  HttpSessionEvent

## 过滤器

1.  FilterConfig
2.  Filter
3.  GenericFilter
4.  HttpFilter
5.   FilterChain

## 监听器

1.  ServletRequestAttributeListener
2.  ServletContextAttributeListener
3.  HttpSessionActivationListener
4.  HttpSessionBindingListener
5.  HttpSessionAttributeListener
6.  HttpSessionIdListener
7.  HttpSessionListener
8.  ServletRequestListener
9.  ServletContextListener
10.   AsyncListener

## Cookie和Session

1.  SessionCookieConfig
2.   HttpSession
3.   Cookie

### Cookie验证器

1.  CookieNameValidator
2.  RFC6265Validator
3.  RFC2109Validator

## 其他类

1.  DispatcherType

## 注解

1.  @MultipartConfig
2.  @WebInitParam
3.   @HandlesTypes
4.   @WebFilter

# Web

## 初始化器

1.  WebApplicationInitializer
2.  SpringServletContainerInitializer

## 请求和响应

1.  MultipartRequest

## 数据绑定

1.  WebDataBinder
2.  WebBindingInitializer

## 监听器

1.  IntrospectorCleanupListener

## 处理器

1. Uri处理器 UriTemplateHandler
2.  web处理器 WebHandler
3. 响应错误处理器  ResponseErrorHandler
4. web异常处理器 WebExceptionHandler
5.  CorsProcessor
6. 

## 过滤器

1.  GenericFilterBean
    1.  OncePerRequestFilter
    2.   AbstractRequestLoggingFilter
    3. 请求上下文过滤器 RequestContextFilter
    4. 表单内容过滤器 FormContentFilter
    5. 编码过滤器 CharacterEncodingFilter
    6.  同源过滤器 CorsFilter
        1.   CorsConfiguration
    7.  RelativeRedirectFilter

## Session 和Cookie

1.  SessionAttributeStore 
2.  WebSessionManager



## 解析器

1. 本地上下文解析器 LocaleContextResolver
2.  Seesion ID 解析器 WebSessionIdResolver
3. 文件解析器 MultipartResolver
4. web参数解析器 WebArgumentResolver
5. 内部路径解析器 InternalPathPatternParser

## 注解类

1. 参见  org.springframework.web.bind.annotation包

## 工具类

1.  HtmlUtils
2.  WebUtils
3.  CorsUtils
4.  TagUtils
5.  UriUtils
6.  UrlPathHelper
7.  JavaScriptUtils
8.  ServletRequestUtils
9.  ServletRequestPathUtils
10.  ServletContextPropertyUtils
11. 

## 异常体系

### Servlet异常

1.  NestedServletException

### 响应异常

1.  ResponseStatusException

### Rest异常

1.  RestClientException

### Http媒介异常

1.  HttpMediaTypeException



# SpringWeb之Http

## 请求和响应

1.  请求状态 HttpStatus 
2. 缓存控制 CacheControl
3.  媒介类型 MediaType
    1.  媒介工厂类 MediaTypeFactory
4.  http头部信息 HttpHeaders
5.  Http实体类  HttpEntity
    1.  RequestEntity
    2.  ResponseEntity

## Http消息

1.  HttpMessage
2.  HttpOutputMessage
3.  HttpInputMessage
4.  HttpRequest
5. TODO

## 消息转换器

1. TODO

# Web MVC

## Servlet

1.  HttpServletBean
2.  FrameworkServlet
3.  DispatcherServlet
4.  AbstractDispatcherServletInitializer
5.  RequestContext
6.  ServerRequest

## 配置器

1.  WebMvcConfigurer
2.  WebMvcConfigurationSupport

## 处理器映射器

1.  DefaultServletHandlerConfigurer
2. HandlerMapping
3.  MatchableHandlerMapping
4.  AbstractHandlerMapping
5.   AbstractUrlHandlerMapping

## 处理器拦截器

1.  HandlerInterceptor
2.  HandlerAdapter

## 控制器

1.  Controller
2.  ViewControllerRegistry

## 版本策略

1.  VersionPathStrategy

## 解析器

### 处理器异常解析器

1.  HandlerExceptionResolver

### 本地化解析器

1.  LocaleContextResolver
2.  LocaleResolver

### 资源解析器

1.  ResourceResolverChain
2. 

## 资源传输器

1.  ResourceTransformer
2.  ResourceTransformerChain

## mvc bean定义及解析器

1.  ScriptTemplateConfigurerBeanDefinitionParser
2.  ViewControllerBeanDefinitionParser
3.  TilesConfigurerBeanDefinitionParser
4.  InterceptorsBeanDefinitionParser
5.  DefaultServletHandlerBeanDefinitionParser

## 视图

1.  View

## 异常

# SpringBoot

## 引导器和运行器

1.  Bootstrapper
2.  BootstrapRegistry
3.  ConfigurableBootstrapContext
4.  DefaultBootstrapContext
5.   BootstrapContext
6.  ApplicationRunner
7.   SpringApplication
    1.  SpringApplicationBuilder
8.  CommandLineRunner
9.  ParentContextApplicationContextInitializer
10.  ContextIdApplicationContextInitializer
11.  ConfigurationWarningsApplicationContextInitializer
12.   进程ID ApplicationPid
13.  ApplicationArguments
    1.  DefaultApplicationArguments
14. 配置类 Configurations
    1.  UserConfigurations

## 上下文和事件

1.  BootstrapContextClosedEvent
2.  ApplicationContextFactory
3.  spring应用事件 SpringApplicationEvent
    1.  环境准备事件 ApplicationEnvironmentPreparedEvent
    2.  应用准备事件 ApplicationPreparedEvent
    3.  应用就绪事件 ApplicationReadyEvent 
    4.  应用启动事件 ApplicationStartingEvent
    5. 应用上下文初始化事件 ApplicationContextInitializedEvent
    6.  应用已启动事件 ApplicationStartedEvent
    7.  应用失败事件 ApplicationFailedEvent

## 环境处理器

1.  EnvironmentConverter
2.  EnvironmentPostProcessorsFactory

## 加载器

### Bean定义加载器

1.  BeanDefinitionLoader

## Banner

1.  Banner
    1.  SpringBootBanner
    2.  ResourceBanner
    3.  ImageBanner

## 异常处理

1.   ExitCodeGenerator
2.   ExitCodeExceptionMapper
3.  SpringBootExceptionReporter

## 资源&资源处理器

1.  YamlProcessor
2.  OriginTrackedYamlLoader
3.  ConfigTreePropertySource
4.  DefaultPropertiesPropertySource
5.  RandomValuePropertySource

## 监听器

1.  FileEncodingApplicationListener
2.  ClearCachesApplicationListener
3.  SpringApplicationRunListener
    1.  EventPublishingRunListener
4.  EnvironmentPostProcessorApplicationListener

## 过滤器

1.  TypeExcludeFilter
2.  LazyInitializationExcludeFilter

## 杂类

1.  WebApplicationType
2.  pid文件写入器 ApplicationPidFileWriter
3.  SpringBootVersion
4.  ApplicationHome
5.  CloudPlatform

# SpringBoot之 AutoConfig

## 初始化器

1.  SharedMetadataReaderFactoryContextInitializer
2.  BackgroundPreinitializer
3.  AutoConfigurations

## 加载器

1.  AutoConfigurationMetadataLoader

## 选择器

1.  AutoConfigurationImportSelector
2.  ImportAutoConfigurationImportSelector

## 处理器

1.  AbstractDependsOnBeanFactoryPostProcessor
2.  AutoConfigurationSorter

## 监听器

1.  AutoConfigurationImportListener

## 过滤器

1.  AutoConfigurationExcludeFilter

## 事件

1.  AutoConfigurationImportEvent