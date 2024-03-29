## Java同步关键字

[TOC]

### as-if-serial语义

不管怎么重排序（编译器和处理器为了提高并行度），（单线程）程序的执行结果不能被改变。编译器、runtime和处理器都必须遵守as-if-serial语义。

### 先行发生原则

```reStructuredText
操作A先行发生于操作B， 其实就是说在发生操作B之前，操作A产生的影响能被操作B观察到 
```

1. volatile变量规则（Volatile Variable Rule） ： 对一个volatile变量的**写操作**先行发生于后面对这个变量的**读操作**
2. 对象终结规则（Finalizer Rule） ： 一个对象的初始化完成（构造函数执行结束）先行发生于它的finalize（） 方法的开始
3. 锁定规则（Monitor Lock Rule） ： 一个unlock操作先行发生于后面对同一个锁的lock操作。 这里必须强调的是同一个锁， 而“后面”是指时间上的先后顺序。
4. 线程启动规则（Thread Start Rule） ： Thread对象的start（） 方法先行发生于此线程的每一个动作。
5. 在一个线程内， 按照程序代码顺序， 书写在前面的操作先行发生于书写在后面的操作。   (指令重排的情况呢)
6. 线程终止规则（Thread Termination Rule） ： 线程中的所有操作都先行发生于对此线程的终止检测， 我们可以通过Thread.join（） 方法结束Thread.isAlive（）
   的返回值等手段检测到线程已经终止执行。
7. 线程中断规则（Thread Interruption Rule） ： 对线程interrupt（） 方法的调用先行发生于被中断线程的代码检测到中断事件的发生， 可以通过Thread.interrupted（） 方法检测到是否有中断发生
8. 传递性（Transitivity） ： 如果操作A先行发生于操作B， 操作B先行发生于操作C，那就可以得出操作A先行发生于操作C的结论。

### volatile的语义

- Volatile关键字能保证变量的原子性,可见性和有序性吗？

  ·**可见性**。对一个volatile变量的读，总是能看到（任意线程）对这个volatile变量最后的写入。当**写**一个volatile变量时，JMM会把该线程对应的本地内存中的共享变量值刷新到主内存。当**读**
  一个volatile变量时，JMM会把该线程对应的本地内存置为无效。线程接下来将从主内存中读取共享变量。

  **·原子性**：对任意单个volatile变量的读/写具有原子性，但类似于volatile++这种复合操作不具有原子性。

  通过**内存屏障指令**禁止指令重排

[volatile的语义与实现](https://www.cnblogs.com/igoodful/p/9473491.html)

### final关键字的语义

- final能够保证变量值对所有线程是可见和一致的,在构造函数内保证final变量不逃逸的情况下,也能保证有序性

- final对于**读写规则**来说
- 写操作:JMM禁止编译器把final域的写重排序到构造函数之外。编译器会在final域的写之后，构造函数return之前，插入一个StoreStore屏障。这个屏障禁止处理器把final域的写重排序到构造函数之外。
- 读操作:初次读对象引用与初次读该对象包含的final域，JMM禁止处理器重排序这两个操作，编译器会在读final域操作的前面插入一个LoadLoad屏障。**如果先读引用对象的属性,再读引用对象,可能出现脏读**

- 对于基础数据类型来说:
    - 在构造函数内对一个final变量的写入，与随后把这个被构造对象的引用赋值给一个引用变量，这两个操作之间不能重排序。
    - 必须先读取引用对象,才能读取引用对象里的final变量,否则可能出现脏读,即两个操作之间不能重排序。

- 对于引用型变量:

- ​ 必须在构造函数内完成对引用型变量的写入,才能读取引用型变量的读取,否则可能出现脏读,这两个操作不能交换顺序,即两个操作之间不能重排序。

- 声明了final关键字的变量或者引用对象不能在构造器return之前逃离

- 不同的处理器可能会对final的内存屏障进行省略,可能出现有序性问题

  #### 参考文档

    - [final关键字详解](https://my.oschina.net/u/4581365/blog/4369508)

## 线程

### 线程池的参数含义？

- **corePoolSize**（线程池的基本大小）：当提交一个任务到线程池时，线程池会创建一个线程来执行任务，即使其他空闲的基本线程能够执行新任务也会创建线程，等到需要执行的任务数大于线程池基本大小时就不再创建。
- **maximumPoolSize**（线程池最大数量）: 任务大于**corePoolSize**,并且任务在队列里放满了,就会继续创建工作线程到**maximumPoolSize**，如果使用无界队列,该参数会失效
- **keepAliveTime**（线程活动保持时间）：工作线程空闲后存活时间
- **RejectedExecutionHandler**（拒绝策略）：当队列和线程池都满了，说明线程池处于饱和状态，那么必须采取一种策略处理提交的新任务
    - AbortPolicy：直接抛出异常。
    - CallerRunsPolicy：只用调用者所在线程来运行任务。
    - DiscardOldestPolicy：丢弃队列里最近的一个任务，并执行当前任务。
    - DiscardPolicy：不处理，丢弃掉。
- 