| pipeline | Sections    | agent   | steps      | stages   |
| -------- | ----------- | ------- | ---------- | -------- |
| post     | environment | options | parameters | triggers |
| tools    | when        | script  | node       | stage    |
| def      |             |         |            |          |
|          |             |         |            |          |
|          |             |         |            |          |

# 关键字

## pipeline

```
 txt代表整条流水线，包含整条流水线的逻辑。
```

## Stages

```tex
流水线中多个stage的容器。stages部分至少包含一个stage。
```

## stage

```tex
阶段，代表流水线的阶段。每个阶段都必须有名称。
```

## steps

```
 代表阶段中的一个或多个具体步骤（step）的容器。steps部分至少包含一个步骤，本例中，echo就是一个步骤。在一个stage中有且只有一个steps。
```

## agent部分

```
指定流水线的执行位置（Jenkins agent）。流水线中的每个阶段都必须在某个地方（物理机、虚拟机或Docker容器）执行，agent部分即指定具体在哪里执行
```

## post

• always：不论当前完成状态是什么，都执行。
• changed：只要当前完成状态与上一次完成状态不同就执行。
• fixed：上一次完成状态为失败或不稳定（unstable），当前完成状态为成功时执行。
• regression：上一次完成状态为成功，当前完成状态为失败、不稳定或中止（aborted）时执行。
• aborted：当前执行结果是中止状态时（一般为人为中止）执行。
• failure：当前完成状态为失败时执行。
• success：当前完成状态为成功时执行。
• unstable：当前完成状态为不稳定时执行。
• cleanup：清理条件块。不论当前完成状态是什么，在其他所有条件块执行完成后都执行。post部分可以同时包含多种条件块

## environment

```
用于设置环境变量，可定义在stage或pipeline部分。
```

##  tools

```
可定义在pipeline或stage部分。它会自动下载并安装我们指定的工具，并将其加入PATH变量中。在agent none的情况下不会生效.tools指令默认支持3种工具：JDK、Maven、Gradle。通过安装插件，tools指令还可以支持更多的工具
```

## input

```
定义在stage部分，会暂停pipeline，提示你输入内容。
```

## options

```
用于配置Jenkins pipeline本身的选项，比如options {retry（3）}指当pipeline失败时再重试2次。options指令可定义在stage或pipeline部分。
```

- buildDiscarder：保存最近历史构建记录的数量。当pipeline执行完成后，会在硬盘上保存制品和构建执行日志，如果长时间不清理会占用大量空间，设置此选项后会自动清理。此选项只能在pipeline下的options中使用
- checkoutToSubdirectory：Jenkins从版本控制库拉取源码时，默认检出到工作空间的根目录中，此选项可以指定检出到工作空间的子目录中
- disableConcurrentBuilds：同一个pipeline，Jenkins默认是可以同时执行多次的，如图3-2所示。此选项是为了禁止pipeline同时执行。在某些pipeline存在抢占资源或调用冲突的场景下，此选项非常有用
- newContainerPerStage：当agent为docker或dockerfile时，指定在同一个Jenkins节点上，每个stage都分别运行在一个新的容器中，而不是所有stage都运行在同一个容器中。
- • retry：当发生失败时进行重试，可以指定整个pipeline的重试次数。需要注意的是，这个次数是指总次数，包括第1次失败。以下例子总共会执行4次。当使用retry选项时，options可以被放在stage块中。
- timeout：如果 pipeline 执行时间过长，超出了我们设置的 timeout 时间，Jenkins 将中止pipeline。以下例子中以小时为单位，还可以以 SECONDS（秒）、MINUTES（分钟）为单位。当使用timeout选项时，options可以被放在stage块中。

## environment

> ```
> 	environment指令可以在pipeline中定义，代表变量作用域为整个pipeline；也可以在stage中定义，代表变量只在该阶段有效。
> 但是这些变量都不是跨pipeline的，值得注意的是，如果在environment中定义的变量与env中的变量重名，那么被重名的变量的值会被覆盖掉。比如在environment中定义PATH变量（PATH也是env中的一个变量）。
> ```

## tigger

```
	只能被定义在pipeline块下，Jenkins内置支持cron、pollSCM，upstream三种方式。其他方式可以通过插件来实现。
	Jenkins trigger cron还设计了一些人性化的别名：@yearly、@annually、@monthly、@weekly、@daily、@midnight和@hourly。例如，@hourly与H****相同，代表一小时内的任何时间；@midnight实际上代表在半夜12：00到凌晨2：59之间的某个时间。
```

parallel：并行执行多个step。在pipeline插件1.2版本后，parallel开始支持对多个阶段进行并行执行。
• parameters：与input不同，parameters是执行pipeline前传入的一些参数。
• triggers：用于定义执行pipeline的触发器。
• when：当满足when定义的条件时，阶段才执行。

## def