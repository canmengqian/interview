[TOC]

# Java

## 基础知识

1.  基础类型有哪些,包装类和基础类型的使用场景？
2. 重载和重写？

## Class类和类加载器

## Object类

1.  waite和notify实现方式,为什么会将这两个方法放在object类里
2. waite 锁持有机制
3.  谈一谈clone方法
4.  谈一谈hashcode()和equals()方法
5.  谈一谈 finalize() 

## Thread

## ThreadLocal

## 反射

## 并发工具类



### Unsafe类和CAS

### AQS和Lock

1. LockSupport

### synchronized

### voliate

### CountDownLatch

### CyclicBarrier

### Phaser

### Semaphore

## 线程池

1.  线程池的7个参数及作用

###  CompletableFuture

###  Executor

###  Executors

###  ExecutorService

###  ThreadPoolExecutor

## 数字类

### Double

1.  Double数值过大和精度过高变为科学计数法
2. double(浮点数)为什么计算会失真

### BigInteger

1.  IntegerCache 存储范围
2.  new Integer() 和 Integer.valueOf ()方法的区别
3.  compare()计算逻辑

### BigDecimal

## 异常体系

1.  java异常分为哪几类,能举例说出几个非受检异常类么

## 字符串

1.  String的 intern()误区
2.  String,StringBuilder,StringBuffer追加字符串的异同点
3.  StringBuilder的扩容策略

## 日历系统

## 集合

### ArrayList 和LinkedList

1.  ArrayList的数据结构,Array.copy的底层实现,ArrayList扩容策略
2. ArrayList初始容量和初始值
3. ArrayList想要变为线程安全，有哪些策略或者替换类
4. Arrays.asList()的注意点
5. ArrayList.subList()的注意点
6.  LinkedList的数据结构,LinkedList扩容策略。随机插入时的算法说一下
7.  ArrayList读写效率VS LinkedList效率

## IO和NIO

## 进程调用器

## 比较器

### Comparable

1.  [Comparable接口的使用](https://blog.csdn.net/weixin_43950014/article/details/114792869)

###  Comparator

# JVM虚拟机

# 设计模式

1.  手写单例 懒汉,饿汉，内部类,枚举类

# Oracle

## 索引

1.  有哪些索引，说一说索引的数据结构
2. 乐观锁是怎么实现的

## 关联

1.  常用的关联，详细说下 外关联,内关联，全关联，自关联
    1. [Oracle的连接详解（左连接、右连接、全连接...）](https://www.cnblogs.com/guogl/articles/5929852.html)
2. oracle 内部访问路径有哪些 ?
3. oracle 内部表连接方式

## SQL

1. 常用SQL调优方式
2. 什么场景下使用SQL并行度

# Spring

## Spring

1. 什么是IOC和AOP，哪些场景下使用过AOP
2. Resource和Autowired区别是什么
3. Spring有哪几种注入方式,同一个Bean里否允许重复注入
4. Spring如何解决循环依赖问题
5. 

## SpringMVC

## Spring事务

1.  spring事务的隔离级别，详细展开
2. 什么是嵌套事务
3. 事务在什么场景下会失效

## SpringBoot

# Redis

1.  redis分布式锁及算法
2. key删除算法
3.  内存淘汰机制
4. 缓存穿透,缓存击穿，缓存雪崩的概念，如何解决上述问题
5. Redis的String内部实现
6. 有使用过redis集群么,哨兵和cluster的区别
7. redis的调优参数