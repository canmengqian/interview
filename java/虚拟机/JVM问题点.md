## JVM问题点

[TOC]

### JVM内存区域

##### JVM运行时内存划分，每个内存区域的作用。

1. **堆区:**所有的对象实例以及数组都要在堆上分配 ，堆中没有内存完成实例分配， 并且堆也无法再扩展时， 将会抛 出OutOfMemoryError异常
2. **程序计数器：**字节码解释器工作时就是通过改变这个计数器的值来选取下一条需要执行的字节码指令， 分支、 循环、 跳转、 异常处理、线程恢复等基础功能都需要依赖这个计数器来完成
3. **虚拟机栈:**Java方法执行的内存模型： 每个方法在执行的同时都会创建一个栈帧（Stack Frame[1]） 用于存储局部变量表、 操作数栈、 动态链接、 方法出口等信息
4. **本地方法栈:**而本地方法栈则为虚拟机使用到的Native方法服务
5. **方法区:**它用于存储已被虚拟机加载的类信息、 常量、 静态变量、 即时编译器编译后的代码等数据

##### 栈上分配和堆上分配的区别

##### 运行时常量池存放的信息

### Java对象

##### 从JVM的角度阐述对象实例的创建过程

1. 遇到**new**指令时， 首先将去检查这个指令的参数是否能在**常量池**中定位到一个类的符号引用， 并且检查这个符号引用代表的类是否已被加载、 解析和初始化过
2. 为对象分配空间的任务等同于把一块确定大小的内存从Java堆中划分出来。 如果内存是绝对规整 ,使用“**指针碰撞**” 进行分配,如果不是,使用“**空闲列表**  ”进行分配
3. **并发情况下也并不是线程安全的**， 可能出现正在给对象A分配内存， 指针还没来得及修改， 对象B又同时使用了原来的指针来分配内存的情况。 采用**CAS**配上失败重试的方式 或者**本地线程分配缓冲**（Thread Local
   Allocation Buffer,TLAB）
4. 分配到的内存空间都初始化为零值
5. **设置对象头,**对象是哪个类的实例、 如何才能找到类的元数据信息、 对象的哈希码、 对象的GC分代年龄等信息。
6. 执行＜init＞方法 ，设置属性值。

##### 指针碰撞和空闲列表的内存分配方式有什么区别

##### 对象头的组成结构

##### 阐述下句柄池和直接指针引用的区别

### 堆内存和GC

#### 堆内存划分

##### 解释Eden空间、 From Survivor空间、 To Survivor空间

计学测算出当内存使用超过98%以上时，内存就应该被minor gc时回收一次。但是实际应用中，我们不能较真的只给 他们留下2%，换句话说当内存使用达到98%时才GC
就有点晚了，应该是多一些预留10%内存空间，这预留下来的空间我们称为S区（有两个s区 s1 和 s0），S区是用来存储新生代GC后存活下来的对象，而我们知道新生代GC算法使用的是复制回收算法。

​ 所以我们实际GC发生是在，新生代内存使用达到90%时开始进行，复制存活的对象到S1区，要知道GC结束后在S1区活下来的对象，需要放回给S0区，也就是对调(对调是指，两个S区位置互换,意味着再一次minor gc 时的区域 是eden
加，上一次存活的对象放入的S区)，既然能对调，其实就是两个区域一般大。这也是为什么会再有个10%的S0区域出来。这样比例就是8:1:1了!!（80%：s1:s0=80%:10%:10%=8:1:1）这里的eden区（80%） 和其中的一个
S区（10%） 合起来共占据90%，GC就是清理的他们，始终保持着其中一个 S 区是空留的，保证GC的时候复制存活的对象有个存储的地方。

#### 垃圾收集器

**引用算法:**引用计数器算法和可达性分析算法的区别，引用计数器算法存在的缺陷？

##### JVM中四种引用

- **强引用**就是指在程序代码之中普遍存在的， 类似“Object obj=new Object（） ”这类的引用， 只要**强引用还存在， 垃圾收集器永远不会回收掉被引用的对象**
- **软引用**关联着的对象， 在系统将要发生内存溢出异常之前， 将会把这些对象**列进回收范围之中进行第二次回收。 如果这次回收还没有足够的内存**， 才会抛出内存溢出异常
- **弱引用**也是用来描述非必需对象的， 但是它的强度比软引用更弱一些， 被弱引用关联的对象只能生存到下一次垃圾收集发生之前。 当垃圾收集器工作时， 无论当前内存是否足够， 都会回收掉只被弱引用关联的对象。
- **虚引用**完全不会对其生存时间构成影响， 也无法通过虚引用来取得一个对象实例。 为一个对象设置虚引用关联的唯一目的就是能在这个对象被收集器回收时**收到一个系统通知**。

##### 常见的垃圾收集算法

- **标记-清除”（Mark-Sweep） 算法，**  算法分为“标记”和“清除”两个阶段： 首先标记出所有需要回收的对象， 在标记完成后统一回收所有被标记的对象， 主要不足有两个： 一个是效率问题， **标记和清除两**
  个过程的效率都不高； 另一个是空间问题， 标记清除之后会产生**大量不连续的内存碎片**， 空间碎片太多可能会导致以后在程序运行过程中需要分配较大对象时， 无法找到足够的连续内存而不得不提前触发另一次垃圾收集动作
- **复制”（Copying） 的收集算法**出现了， 将可用内存按容量划分为大小相等的两块， 每次只使用其中的一块。 当这一块的内存用完了，就将还存活着的对象复制到另外一块上面， 然后再把已使用过的内存空间一次清理掉。
  这样使得每次都是对整个半区进行内存回收， 内存分配时也就不用考虑内存碎片等复杂情况， 只要移动堆顶指针， 按顺序分配内存即可， 实现简单， 运行高效。 只是这种算法的代价是将内存缩小为了原来的一半， 未免太高了一点
- **“标记-整理”（Mark-Compact） 算法**， 标记过程仍然与“标记-清除”算法一样， 但后续步骤不是直接对可回收对象进行清理， 而是让所有存活的对象都向一端移动， 然后直接清理掉端边界以外的内存
- **分代收集”（Generational Collection） 算法**，根据对象存活周期的不同将内存划分为几块。 一般是把**Java堆分为新生代和老年代**， 这样就可以根据各个年代的特点采用最适当的收集算法。 在新生代中，
  每次垃圾收集时都发现有大批对象死去， 只有少量存活， 那就选用复制算法， 只需要付出少量存活对象的复制成本就可以完成收集。

##### Java中的垃圾收集器

- **Serial收集器**: 新生代收集器是一个单线程的收集器， 但它的“单线程”的意义并不仅仅说明它只会使用一个CPU或一条收集线程去完成垃圾收集工作， 更重要的是在它进行垃圾收集时， 必须暂停其他所有的工作线程，
- **ParNew收集器**其实就是Serial收集器的多线程版本， 使用多条线程进行垃圾收集
- **Parallel Scavenge收集器是**一个新生代收集器， 它也是使用复制算法的收集器， 又是并行的多线程收集器 ，侧重于吞吐量
- **Serial Old ：**是Serial收集器的老年代， 一个单线程收集器， 使用“标记-整理”算法。 这个收集器的主要意义也是在于给Client模式下的虚拟机使用。
- **Parallel Old**是Parallel Scavenge收集器的老年代版本， 使用多线程和“标记-整理”算法。
- **CMS（Concurrent Mark Sweep） 收集器**  :基于“标记—清除”算法
- **G1（Garbage-First） 收集器**  ：基于“标记—整理”算法实现的收集器 ,G1运作期间不会产生内存空间碎片

##### 内存分配策略

- **对象优先在Eden分配**  ,对象在新生代Eden区中分配。 当Eden区没有足够空间进行分配时， 虚拟机将发起一次Minor GC
- **大对象直接进入老年代**
- **长期存活的对象将进入老年代**
- **动态对象年龄判定**
- **空间分配担保**

##### 什么时候触发YungGc和FullGc

- 触发MinorGC(Young GC)
    - 老年代最大的**可用连续空间**是否大于新生代的**所有对象**总空间
        - 如果大于的话，直接执行minorGC
        - 如果小于，判断是否开启HandlerPromotionFailure，没有开启直接FullGC
        - 如果开启了HanlerPromotionFailure, JVM会判断老年代的最大连续内存空间是否大于历次晋升的大小，如果小于直接执行FullGC，如果大于的话，执行minorGC
- 触发FullGC
    - 大对象直接进入老年代,老年代空间也不足，就会触发Full GC
    - 永久代空间不足,解决方法增大永久代空间
    - YGC发生时晋升到老年代的平均总大小大于老年代的空闲空间

##### JVM常用参数

- | 参数                                               | 备注                                                     | 参数                                                         | 备注                                          |
    | -------------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------ | --------------------------------------------- |
  | -Xms20M、 -Xmx20M、 -Xmn10M                        | 堆的最小值,堆的最大值                                    | -XX：SurvivorRatio=8                                         | 新生代中Eden区与一个Survivor区的空间比例是8:1 |
  | -XX： +PrintGCDetails                              | 收集器日志参数                                           | -XX： PretenureSizeThreshold                                 | 大于这个设置值的对象直接在老年代分配          |
  | –XX:NewRatio                                       | 新生代 ( Young ) 与老年代 ( Old ) 的比例                 | -XX： MaxTenuringThreshold                                   | 设置对象晋升老年代的年龄阈值                  |
  | -XX： PermSize -XX： MaxPermSize                   | 永久代大小                                               | -HandlePromotionFailure                                      | 是否允许担保分配                              |
  | -XX： MaxDirectMemorySize                          | 直接内存的大小                                           | -XX：+TraceClassLoading -XX： +TraceClassUnLoading          | 查看类加载和卸载信息                          |
  | -XX：+UseCompressedOops                            | 普通对象指针压缩                                         | -XX： +PrintAssembly                                         | 把动态生成的本地代码还原为汇编代码输出        |
  | -XX ：+HeapDumpOnOutOfMemoryError                  | 让虚拟机在出现内存溢出异常时Dump出当前的内存堆转储快照   | -XX：+TieredCompilation                                      | 开启分层编译策略                              |
  | -XX：+UseConcMarkSweepGC<br>          +UseParNewGC | 使用CMS收集器</br> 使用CMS收集器                         | -XX： +UseLWPSynchronization（默认值） 和-XX： +UseBoundThreads | 指定虚拟机使用哪种线程模型                    |
  | -XX： ParallelGCThreads                            | 限制垃圾收集器线程数                                     | -XX：+UseSpinning                                            | 开启自旋锁                                    |
  | -XX： MaxGCPauseMillis                             | 控制最大垃圾收集停顿时间                                 | -XX： PreBlockSpin                                           |                                               |
  | -XX：GCTimeRatio                                   | 直接设置吞吐量大小                                       | -XX： +UseBiasedLocking                                      | 是否启用偏向锁                                |
  | -XX：+UseCMSCompactAtFullCollection                | 内存不足时进行内存碎片的合并整理                         |                                                              |                                               |
  | -XX： CMSFullGCsBeforeCompaction                   | 用于设置执行多少次不压缩的Full GC后， 跟着来一次带压缩的 |                                                              |                                               |
  | -XX：<br/>MaxGCPauseMillis=50                      | 设置期望停顿的最大值                                     |                                                              |                                               |

YangGC 和 FullGc的区别？

### 类加载机制

- JVM中类的完整生命周期P259
- 类强制初始化的场景,被动初始化 P259
- 验证阶段:文件格式验证、 元数据验证、 字节码验证、 符号引用验证。
- 解析阶段:类或接口 ，字段 ，类方法 ,接口方法
- <clinit>()的执行流程 P272
- 静态语句块的非法向前引用 P272
- 静态语句块,构造器语句块,构造器的执行流程 P272

#### 类加载器

- Class对象的equals（） 方法、isAssignableFrom（） 方法、 isInstance() P276
- Bootstrap ClassLoader ,ExtClassLoader ，Application ClassLoader 三个类加载器的作用
- 说一说双亲委派模型

### 字节码和指令集

### 内存模型和多线程

#### 并发模型

- 什么是缓存一致性协议,常见的一致性协议有哪些？
- Java中的8个一致性指令
- Volatile,synchronized,final对变量一致性,原子性,可见性的保证
- 什么是Happen-Before原则
- 汇编指令Lock的作用 P9 `《java并发机制的底层实现原理》`
- 处理器如何实现原子操作 P18 `《java并发机制的底层实现原理》`
- 什么是指令重排,编译器优化的重排序,指令级并行的重排序,内存系统的重排序
- 内存屏障指令都有哪些
- 什么是重排序,重排序对多线程的影响,如何规避掉重排序带来的影响？

#### 锁机制

- 偏向锁,轻量级锁,重量级锁,悲观锁,乐观锁,互斥锁,自旋锁是什么意思

#### 线程

- suspend()、resume()和stop()方法为什么被废弃
- Java中的阻塞队列
- Java中的原子类
- CountDownLatch，CyclicBarrier，Semaphore，Exchange的作用
- 线程池的参数的解释