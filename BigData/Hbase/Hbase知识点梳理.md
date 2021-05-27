## Hbase知识点梳理(Hbase不睡觉书)

[TOC]

### Hbase使用场景

- 数据分析是HBase的弱项， 因为对于HBase乃至整个NoSQL生态圈来说， 基本上都是不支持表关联的。
- 单表数据量超千万， 而且并发还挺高。

### Hbase架构

#### Master服务器和RegionServer服务器

#### 什么是Region,行,列族,列，cell

#### RegionServer和Region的存储结构

#### 什么是预写日志(WAL)

##### WAL的同步和异步写入

#### Store模块的MemStore和HFile的作用

##### BlockCache是什么

##### HFile之前已经被存储到HDFS一次了， 为什么还需要被放入Memstore

##### 什么是LSM树

##### HFIle的存储结构

- HFile- Data数据结构
- BlockType 包含哪些类型
- KeyValue类 数据结构

### Hbase数据读写

#### 数据读写

- keyValue的写入流程
- keyValue的读取流程
- 打上了删除标记的数据在什么时候会被删除

#### Regin定位

- 客户端发起的请求如何定位到具体的Regin？

### Hbase优化专题

#### BlockCache的类型

##### 基于堆内存的LRUBlockCache

##### 堆外内存的SlabCache

##### BucketCache  

