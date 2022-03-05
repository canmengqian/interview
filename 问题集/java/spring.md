[TOC]

## Spring组件列表



|            组件名称            |      作用      | 是否需要了解 | 完成度(无需,未完成,阅读完成,源码分析) |
| :----------------------------: | :------------: | :----------: | :-----------------------------------: |
| Spring Configuration Processor |   bean 配置    |              |                                       |
|        Spring Security         |    安全认证    |      是      |                                       |
|         Spring CredHub         |      凭证      |              |                                       |
|         Spring Session         |  session处理   |              |                                       |
|   Spring Session Data Redis    |  session处理   |              |                                       |
|        Spring GraphQLs         |                |              |                                       |
|          Spring Batch          |     批处理     |      是      |                                       |
|          Spring LDAP           |  文件资源访问  |      否      |                 无需                  |
|          Spring Shell          |   shell终端    |      是      |                未完成                 |
|      Spring Statemachine       |     状态机     |              |                                       |
|      Spring Web Services       |  web Service   |      否      |                 无需                  |
|            Actuator            |      监控      |      是      |                未完成                 |
|        SpringBoot Admin        |      监控      |      是      |                未完成                 |
|     Spring Cloud Contract      |    契约测试    |              |                                       |
|      SpringCloud Function      |                |              |                                       |
|        SpringCloud Task        |                |              |                                       |
|             Rureka             |    服务发现    |              |                                       |
|           ZooKeeper            |                |              |                                       |
|            GateWay             |    网关服务    |              |                                       |
|          LoadBalancer          |     软负载     |              |                                       |
|             Feign              | 三方请求客户端 |              |                                       |
|                                |                |              |                                       |



## Spring

- [produces在@requestMapping中的使用方式和作用](https://blog.csdn.net/jaryle/article/details/72965885)
- [@requestMapping的produces和consumes属性](https://blog.csdn.net/zhanyu1/article/details/82849490)
- [@RequestParam和@RequestBody的区别](https://blog.csdn.net/feiyst/article/details/88431621)
- [SpringBoot+Ajax文件上传+FormData表单提交](https://blog.csdn.net/rocling/article/details/81639141?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control)
- [springboot-运行单元测试-异常与排除](https://blog.csdn.net/matrixbbs/article/details/88567157)
- [springboot单元测试](https://www.cnblogs.com/fnlingnzb-learner/p/12068505.html)
- [SpringBoot三种获取Request和Response的方法](https://blog.csdn.net/jiulanhao/article/details/83068952)
- [swagger-bootstrap-ui 访问权限控制](https://blog.csdn.net/u010192145/article/details/89514376)
- [springboot2.x基础教程：JRebel实现SpringBoot热部署](https://juejin.cn/post/6865287907348938765)
- [Springboot @Transactional捕获异常事务回滚](https://blog.csdn.net/weixin_42411588/article/details/84986107)
- [浅谈Spring之@Nullable、@NonNull注解](https://blog.csdn.net/yaomingyang/article/details/87254451)
- [Spring Boot自定义Start组件开发](https://www.cnblogs.com/linjiqin/p/13436943.html)
- [FastJson 序列化java bean中的属性顺序问题(alibaba.fastjson)](https://blog.csdn.net/weixin_34128534/article/details/92054500)
- [springboot集成beetlsql以及支持多数据源](https://blog.csdn.net/wuyang19920226/article/details/100084459)
- [无限极分类JAVA 实现 Tree](https://blog.csdn.net/qq_15371293/article/details/107367309)
- [Spring WebFlux运用中的思考与对比](https://www.codenong.com/c3128861/)
- [一个接口多个实现类的Spring注入方式](https://www.cnblogs.com/leeego-123/p/10882069.html)
- [Spring项目读取resource下的文件](https://www.cnblogs.com/-beyond/p/11689291.html)
- [SpringBoot读取Resource下文件的几种方式](https://blog.csdn.net/xiyang_1990/article/details/96314461)
- [使用Spring Aop(@Aspect)加自定义注解记录日志以及请求响应时间](https://blog.csdn.net/Muscleheng/article/details/97136260)
- [SpringBoot读取外部配置文件的方法](https://www.cnblogs.com/eternityz/p/12511777.html)
- [Spring注解——同一接口有多个实现类，如何注入？@Resource、@Autowired、@Qualifier](https://blog.csdn.net/u010476994/article/details/80986435)
- [想用@Autowired注入static静态成员？官方不推荐你却还偏要这么做](https://zhuanlan.zhihu.com/p/161223943)

## Spring注解

### Spring Conditional 注解

- [Spring @Conditional注解 详细讲解及示例](https://blog.csdn.net/xcy1193068639/article/details/81491071)

### Spring Role 类注解

### 资源和配置类

## Spring EL

- [SpEL表达式总结](https://www.jianshu.com/p/e0b50053b5d3)
- [springboot入门04 – 使用SpEL表达式](https://www.zhyea.com/2019/11/27/springboot-base-04-use-spel.html)
- [【SpringBoot 基础系列】SpEL 语法扫盲与查询手册 ](https://www.cnblogs.com/yihuihui/p/12928323.html)
- [Spring 表达式语言（SpEL）入门实战](https://blog.csdn.net/shichen2010/article/details/96504008)
- [Spring5参考指南: SpEL](https://www.cnblogs.com/flydean/p/12680386.html)

## Spring Shell 

- [Spring Shell 中文文档](https://blog.csdn.net/u012881904/article/details/103329612)
- [Spring系列学习之Spring Shell命令行](https://blog.csdn.net/boonya/article/details/85218773)
- [深入理解 SpringBoot 注解 @ShellMethod](https://starrier.starrier.org/blogs/annotation-shellmethod.html)
- [SpringShell命令分组-@ShellCommandGroup](https://www.jianshu.com/p/adce6e99ed83)
- [ShellOption使用教程](https://www.cnblogs.com/nuccch/p/11067342.html#spring-shell%E6%98%AF%E4%BB%80%E4%B9%88)
- [参数校验](https://www.cnblogs.com/nuccch/p/11067342.html#spring-shell%E6%98%AF%E4%BB%80%E4%B9%88)
- [@ShellMethodAvailability](https://www.cnblogs.com/nuccch/p/11067342.html#spring-shell%E6%98%AF%E4%BB%80%E4%B9%88)
- [Spring Shell入门介绍](https://www.cnblogs.com/nuccch/p/11067342.html)

## Spring加解密



## Spring Cache

- [使用@EventListener 和@Cacheable 来初始化缓存](https://www.thinbug.com/q/41699464)
- [在@PostConstruct期间使用@Cacheable的Spring缓存不起作用](https://www.stacknoob.com/s/u2gsUEJbRN927FM4URfNK8)
- [Spring之缓存注解@Cacheable](https://www.cnblogs.com/yuluoxingkong/p/10143810.html)
- [@Cacheable 拼接key的操作](https://zhuxianfei.com/java/44978.html)
- [[Spring]~@JsonPropertyOrder（序列化时字段排序）](https://blog.csdn.net/qq_36841482/article/details/103388200)
- [springboot项目获取yml配置的三种方法](https://blog.csdn.net/weixin_45690436/article/details/106544754)
- [SpringCache常用注解及key中参数值为null的问题解析](https://blog.csdn.net/qq_34972627/article/details/91510820)
- [spring缓存注解的condition属性](https://blog.csdn.net/hallytude/article/details/53769055)
- [Spring缓存注解@Cacheable、@CacheEvict、@CachePut使用](https://www.cnblogs.com/fashflying/p/6908028.html)
- [springboot入门01 – 缓存的使用](https://www.zhyea.com/2019/08/25/springboot-base-using-cache.html)

## Spring Validation

- [Spring 参数校验的异常处理](https://juejin.cn/post/6844904003684302861)
- [出现Not registered via @EnableConfigurationProperties or marked as Spring component](https://blog.csdn.net/weixin_41070914/article/details/89320361)
- [使用maven profile指定配置文件打包适用多环境](https://blog.csdn.net/qiaqia609/article/details/79507675)
- [spring @Validated 注解开发中使用group分组校验](https://blog.csdn.net/lklihaikunkun/article/details/80605425)

## Spring Swagger

- [swagger2在线文档@validated接口校验](https://blog.csdn.net/zx779441202/article/details/80020639)
- [spring StopWatch用法](https://www.cnblogs.com/kaituorensheng/p/7105639.html)
- [SpringBoot的application.yml如何引用其他的配置文件](https://bbs.csdn.net/topics/392357059)
- [springboot项目javax.validation使用](https://www.cnblogs.com/eyesfree/p/12780523.html)
- [swagger开发接口，实现验证的入参校验Dto类](https://blog.csdn.net/luojiawen208/article/details/106731939/)

## SpringBoot

- [Spring Boot 配置文件和命令行配置](https://www.cnblogs.com/fishpro/p/spring-boot-study-cfg.html)
- [Springboot配置使用ssl，使用https](https://www.cnblogs.com/duanxz/p/9155509.html)
- [spring boot排除扫描类的三种方式](https://blog.csdn.net/micro_hz/article/details/98883597)
- [Spring Boot 项目瘦身指南，瘦到不可思议](https://www.cnblogs.com/niceyoo/p/14083706.html)
- [SpringBoot 官方建议我们不要随意摆放 Application 启动类](https://my.oschina.net/nimo10050/blog/4937984)
- [SpringBoot测试Controller层](https://www.cnblogs.com/caofanqi/p/10836459.html)
- [Springboot中如何引入本地jar包，并通过maven把项目成功打包成jar包部署](https://www.cnblogs.com/liukunjava/p/9577768.html)

## SpringBatch

- [spring batch数据库表数据结构](http://www.kailing.pub/article/index/arcid/194.html)
- [决战数据库-spring batch(4)数据库到数据库](https://blog.csdn.net/masson32/article/details/91351279)

- [欠你们的SpringBatch数据库分析，终于有时间整理了](https://baijiahao.baidu.com/s?id=1645167255676713457&wfr=spider&for=pc)
- [Springboot 整合 spring batch 实现批处理 ，小白文实例讲解](https://blog.csdn.net/qq_35387940/article/details/108193473)
- [大量数据也不在话下，Spring Batch并行处理四种模式初探](https://zhuanlan.zhihu.com/p/240965776)
- [通过例子讲解Spring Batch入门，优秀的批处理框架](https://www.pkslow.com/archives/spring-batch-introduction)
- [spring batch结合定时任务记录每一次结果](https://blog.csdn.net/u014172271/article/details/80413135/)

## WebSocket

- [使用四种框架分别实现百万websocket常连接的服务器](https://colobu.com/2015/05/22/implement-C1000K-servers-by-spray-netty-undertow-and-node-js/#Netty%E6%9C%8D%E5%8A%A1%E5%99%A8)
- [Websocket定时推送消息到浏览器端](https://blog.csdn.net/weixin_35654814/article/details/102733218)
- [Springboot+websocket+定时器实现消息推送](https://www.cnblogs.com/dand/p/10319031.html)
- [实现单台测试机6万websocket长连接](https://segmentfault.com/a/1190000017364433)
- [websocket并发量,各大浏览器最大socket连接数](https://blog.csdn.net/weixin_41217541/article/details/106231171)
- [SpringBoot集成WebSocket长连接实际应用](https://blog.csdn.net/wwx692371700/article/details/106442026/)

## SpringAdmin

- [Spring Boot Admin 2.1.0 全攻略](https://juejin.cn/post/6844903757721894920)
- [应用监控之 Spring Boot Admin 使用及配置](https://blog.csdn.net/u014217825/article/details/103061261/)
- [Spring Boot Admin](https://greedypirate.github.io/2018/09/07/Spring-Cloud%E7%B3%BB%E5%88%97-Spring-Boot-Admin/#Spring-Boot-Admin%E4%BB%8B%E7%BB%8D)
- [SpringBoot入坑指南之四：使用Spring Boot Admin进行服务监控](https://www.jianshu.com/p/25d5a85ce8dd)
- [Spring Boot Admin的使用](https://zhuanlan.zhihu.com/p/140675547)

## Skywalking

- [Skywalking部署及使用](https://www.jianshu.com/p/8b9aad4210c5)
- [Skywalking：Java Agent配置](https://blog.csdn.net/lt326030434/article/details/107121511/)
- [Skywalking系列博客4-Java Agent配置](https://blog.csdn.net/lilizhou2008/article/details/107050692/?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-0&spm=1001.2101.3001.4242)
- [Skywalking：Java Agent配置](https://blog.csdn.net/lt326030434/article/details/107121511/)
- [SkyWalking 微服务监控分析](https://skywalking.apache.org/zh/2019-01-03-monitor-microservice/)
- [SkyWalking - 实现微服务监控告警](https://blog.51cto.com/zero01/2463976)
- [skywalking+mysql配置](https://blog.csdn.net/weixin_37799575/article/details/102663336)

## Spring分布式事务

- [Seata实战-分布式事务简介及demo上手](https://blog.csdn.net/hosaos/article/details/89136666)
- [数据量大了一定要分表，分库分表组件Sharding-JDBC入门与项目实战](https://segmentfault.com/a/1190000023443700)
- [分库分表神器 Sharding-JDBC，几千万的数据你不搞一下？](https://segmentfault.com/a/1190000038225441)
- [分库分表：中间件方案对比](https://blog.csdn.net/fly910905/article/details/87101059)
- [数据库分库分表中间件对比（很全）](https://blog.csdn.net/xuheng8600/article/details/80336094?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_baidulandingword-0&spm=1001.2101.3001.4242)
- [分布式事务：Saga模式](https://www.jianshu.com/p/e4b662407c66)
- [spring boot 分布式事务解决方案LCN](https://www.cnblogs.com/dousnl/p/9772632.html)
- [如何选择分布式事务解决方案？](https://springboot.io/t/topic/1969)

## Actuator 

- [Spring Boot 2.X(十六)：应用监控之 Spring Boot Actuator 使用及配置](https://www.cnblogs.com/zwqh/p/11851300.html)
- [SpringBoot监控Actuator，关闭redis监测](https://blog.csdn.net/zzzgd_666/article/details/106398042)
- [Spring Boot 2.3 优雅关闭新姿势，真香！](https://www.cnblogs.com/javastack/p/12986445.html)
- [Springboot 优雅停止服务的几种方法！](https://mp.weixin.qq.com/s/UVSnl_wuS-31hn0qaPaqlg)

## Undtertow

- [SpringBoot2使用Undertow来提高应用性能（spring-boot-starter-undertow）](https://blog.csdn.net/moshowgame/article/details/84985765)
- [undertow简单入门](https://www.jianshu.com/p/08cf875c5078)
- [UnderTow Access.log格式](https://blog.csdn.net/zhxdick/article/details/85231537)
- [SPRINGBOOT UNDERTOW ACCESSLOG格式](https://www.freesion.com/article/54151292180/)

## Retry

- [springboot 整合retry（重试机制）](https://www.cnblogs.com/lywJ/p/10730904.html)
- [重试框架Spring retry实践](https://blog.csdn.net/u011116672/article/details/77823867)

## Logback

- [把logback.xml放到jar外面](https://blog.csdn.net/zhengdesheng19930211/article/details/64443626)
- [Spring Boot 配置文件和日志文件放到jar之外](https://blog.csdn.net/supper10090/article/details/78285365/)

## Spring Cloud Contract：契约测试

- 

## SpringTest

- [【SpringBoot】掌握这两个属性，你的测试类可以启动的更快些](https://juejin.cn/post/6844904096839761933)

- [SpringBoot测试Controller层](https://www.cnblogs.com/caofanqi/p/10836459.html)

## 静态资源

- [SpringBoot 如何配置静态资源的地址与访问路径](https://blog.csdn.net/csdnluolei/article/details/86715333)
- [SpringBoot 静态资源 使用项目外部路径图片 跨域问题CORS 解决](https://blog.csdn.net/h356363/article/details/90547998)
- [【SpringBoot】静态资源规则配置](https://blog.csdn.net/qq877728715/article/details/110422199)

## 杂项

- [SpringBoot2.x 给Controller的RequestMapping添加统一前缀](https://blog.csdn.net/gzt19881123/article/details/104530561)
- [springboot-整合多数据源配置](https://www.cnblogs.com/aizen-sousuke/p/11756279.html)