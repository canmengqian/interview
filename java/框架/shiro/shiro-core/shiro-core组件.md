[TOC]

# 组件分类

| 组件名称   | 描述 | 重要程度                       |
| ---------- | ---- | ------------------------------ |
| authc      |      | :star::star::star::star::star: |
| authz      |      | :star::star::star::star::star: |
| cache      |      |                                |
| codec      |      | :star::star::star::star::star: |
| concurrent |      |                                |
| config     |      | :star::star::star::star::star: |
| crypto     |      |                                |
| dao        |      |                                |
| env        |      |                                |
| functor    |      |                                |
| io         |      |                                |
| mgt        |      | :star::star::star::star::star: |
| realm      |      | :star::star::star::star::star: |
| session    |      | :star::star::star:             |
| subject    |      | :star::star::star::star:       |
| util       |      |                                |



# 组件

## 配置  config

### Bean事件

1.  BeanEvent
   1.  InitializedBeanEvent
   2.  InstantiatedBeanEvent
   3.  可配置bean: ConfiguredBeanEvent
   4.  DestroyedBeanEvent

### 插值器 Interpolator

1.  DefaultInterpolator
2.  CommonsInterpolator

### Ini对象

1.  ini
2.  IniFactorySupport

## 缓存 cache

### 缓存管理器 CacheManager

1.  AbstractCacheManager
   1.  基于内存的cache MemoryConstrainedCacheManager
2. Ehcache管理器 EhCacheManager
3.  CacheManagerAware

### cache对象

1.  Cache
   1. KV键值对 MapCache
   2. Ehcache

## 编码 codec

1.  Base64
2.  CodecSupport
3.  H64
4.  Hex

## 事件 Event

### 事件总线

1.  Event
2.  EventBusAware
3.   EventBus
   1.   DefaultEventBus

### 事件监听器

1.  EventListener
   1.  TypedEventListener
   2.  SingleArgumentMethodEventListener
2.  EventListenerComparator
3.  EventClassComparator

### 事件监听器解析器

1.  EventListenerResolver
   1.   AnnotationEventListenerResolver
2.  Subscribe

## 环境 Env

1.   Environment
   1.  NamedObjectEnvironment
   2.  DefaultEnvironment
   3.  BasicIniEnvironment

## 管理 mgt

### 安全管理器

1.   SecurityManager
   1.  基于缓存的安全管理器:  CachingSecurityManager
   2.  基于realm的安全管理器: RealmSecurityManager
   3.  基于认证的安全管理器: AuthenticatingSecurityManager
   4.  基于授权的安全管理器: AuthorizingSecurityManager
   5.   基于session的安全管理器:SessionsSecurityManager
   6.  默认的安全管理器DefaultSecurityManager

### 记住我管理器

1.  RememberMeManager
   1.  AbstractRememberMeManager

### subject工厂

1.  SubjectFactory
   1.   DefaultSubjectFactory
2.  SubjectDAO
   1.   DefaultSubjectDAO

### Session存储剔除器

1.  SessionStorageEvaluator
   1.  DefaultSessionStorageEvaluator

## Subject

### 协议集合

1.  PrincipalCollection
   1.  可变协议集合: MutablePrincipalCollection
      1.   SimplePrincipalCollection
   2. 协议Map： PrincipalMap
      1.   SimplePrincipalMap

### subject

1.  Subject
   1.   DelegatingSubject
2.  SubjectContext
   1.   DefaultSubjectContext

### 其他

1.  SubjectThreadState
2.  SubjectCallable
3.  SubjectRunnable

## Session

### session管理器
1.	SessionManager
   1.	  AbstractSessionManager
   2.	  NativeSessionManager
      1.	 AbstractNativeSessionManager
   3.	  ValidatingSessionManager
      1.	 AbstractValidatingSessionManager
      2.	 DefaultSessionManager

### Session

1.  Session
   1.   ValidatingSession
      1.  SimpleSession
   2.   ProxiedSession
      1.  ImmutableProxiedSession
   3.   DelegatingSession
2.  SessionKey
   1.   DefaultSessionKey
3.  SessionValidationScheduler
   1.  ExecutorServiceSessionValidationScheduler

### Session工厂

1.  SessionFactory
   1.   SimpleSessionFactory
2.  SessionContext
   1.  DefaultSessionContext

### session监听器

1.  SessionListener
   1.   SessionListenerAdapter

## 加解密 crypto

### 加解密服务

1.  CipherService
   1.   JcaCipherService
   2.   AbstractSymmetricCipherService
   3.  默认阻塞加密服务: DefaultBlockCipherService
      1.  Blowfish加密服务 : BlowfishCipherService
      2. AES算法: AesCipherService

### Hash算法

1. Hash
   1.   SimpleHash
      1.  Md5hash
      2.  Sha384Hash
      3.  Sha512Hash
      4.  Sha1Hash
      5.  Md2Hash
      6.   Sha256Hash

### Hash算法格式化

1.   HashFormat
   1.   ParsableHashFormat
   2.  ModularCryptFormat
      1.  Shiro1CryptFormat
   3.  HexFormat
   4.  Base64Format
2.  HashFormatFactory
   1.   DefaultHashFormatFactory

### Hash算法服务

1.  HashService
   1.   ConfigurableHashService
   2.  DefaultHashService

### 随机数生成器

1.  RandomNumberGenerator
   1.   SecureRandomNumberGenerator

### 枚举

1. ProvidedHashFormat
2.  PaddingScheme
3.  OperationMode

## Realm

### Realm接口

1.  Realm
   1.  基于缓存realm:CachingRealm
   2.  基于认证的realm： AuthenticatingRealm
   3. 基于授权的realm： AuthorizingRealm
      1.  简单账户realm： SimpleAccountRealm
      2.  JDBC realm： JdbcRealm
      3.  LDAP realm: AbstractLdapRealm
         1.   ActiveDirectoryRealm
      4.  JndiLdapRealm
      5.  DefaultLdapRealm
2.  realm工厂:  RealmFactory
   1.   JndiRealmFactory
3.   LdapContextFactory

### 工具类

1.   LdapUtils

### 枚举

1.  SaltStyle

## 认证 authc

### 身份匹配器

1.  CredentialsMatcher
   1.  简单身份匹配器: SimpleCredentialsMatcher
      1.  基于Hash匹配器： HashedCredentialsMatcher
      2.  密码匹配器:PasswordMatcher
      3.  通用匹配器: AllowAllCredentialsMatcher

### 认证策略

1.  AuthenticationStrategy
   1.  抽象认证策略 AbstractAuthenticationStrategy
      1.  至少认证成功一次: AtLeastOneSuccessfulStrategy
      2. 全部认证成功: AllSuccessfulStrategy
      3. 首次认证成功: FirstSuccessfulStrategy

### 认证信息

1.  AuthenticationInfo
   1.  合并认证接口: MergableAuthenticationInfo
   2.  加盐认证接口: SaltedAuthenticationInfo
      1.   简单认证信息: SimpleAuthenticationInfo
2.  账户:Account
   1.   SimpleAccount

### 认证Token

1.  AuthenticationToken
   1.  记住我认证:RememberMeAuthenticationToken
   2.  主机认证: HostAuthenticationToken
      1.   用户名密码认证: UsernamePasswordToken
      2.  BearerToken

### 密码服务

1.  PasswordService
   1.  hash密码服务: HashingPasswordService
   2.  默认的密码服务: DefaultPasswordService

## 授权 authz

### 权限

1.  Permission
   1.   通用权限: WildcardPermission
   2. 域权限: DomainPermission
   3.  AllPermission

### 权限认证操作

1.  Authorizer
   1.   ModularRealmAuthorizer

### 权限解析器

1.  PermissionResolver
   1.   WildcardPermissionResolver

### 授权信息

1.  AuthorizationInfo
   1.   SimpleAuthorizationInfo

### 角色权限解析器

1.  RolePermissionResolver

### 异常体系

### 授权拦截器

1.  AuthorizingMethodInterceptor
   1.  AnnotationsAuthorizingMethodInterceptor

### 注解

1.  权限认证:@RequiresAuthentication
2.  是否满足权限:@RequiresPermissions
3. 访客模式: @RequiresGuest
4. 是否满足角色: @RequiresRoles
5.  是否满足用户: @RequiresUser

## 工具类

1. 权限工具类: PermissionUtils
2. 集合工具类: CollectionUtils
3. 生命周期工具类: LifecycleUtils
4. 字符串工具类: StringUtils
5. JDBC工具类: JdbcUtils
6.  ClassUtils



