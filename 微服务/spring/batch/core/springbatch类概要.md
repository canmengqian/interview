[TOC]

# 常用注解

| 类                     | 描述说明 |
| ---------------------- | -------- |
| @JobScope              |          |
| @StepScope             |          |
| @EnableBatchProcessing |          |

# Base

## StepListener :star:

| 类                    | 描述说明 |
| --------------------- | -------- |
| ItemReadListener      |          |
| ItemWriteListener     |          |
| StepExecutionListener |          |
| SkipListener          |          |
| ChunkListener         |          |
| JobExecutionListener  |          |
| ItemProcessListener   |          |

## Entity

| 类            | 描述说明 |
| ------------- | -------- |
| StepExecution |          |
| JobInstance   |          |
| JobExecution  |          |

## JobKeyGenerator

| 类                     | 描述说明 |
| ---------------------- | -------- |
| DefaultJobKeyGenerator |          |

## BatchStatus

```
COMPLETED, STARTING, STARTED, STOPPING, STOPPED, FAILED, ABANDONED, UNKNOWN;
```



# configuration:

## JobLocator:

## JobRegistry:job注册接口:star:

| 类名                           |      |      |
| ------------------------------ | ---- | ---- |
| MapJobRegistry                 |      |      |
| **其他**                       |      |      |
| JobFactoryRegistrationListener |      |      |
| AutomaticJobRegistrar          |      |      |

## JobLoader: :star:

```
加载应用程序上下文并注册所有作业
```

| 类               | 描述说明 |
| ---------------- | -------- |
| DefaultJobLoader |          |

## JobFactory:star:

| 类名                         |      |      |
| ---------------------------- | ---- | ---- |
| ApplicationContextJobFactory |      |      |
| ReferenceJobFactory          |      |      |

## AbstractBatchConfiguration 

```txt
基本配置类提供了启用和使用Spring Batch的通用结构
```

| 类                        | 描述说明 |
| ------------------------- | -------- |
| SimpleBatchConfiguration  |          |
| ModularBatchConfiguration |          |

## BatchConfigurer:批处理配置器:star:

```
批处理配置器
```

| 类                     | 描述说明 |
| ---------------------- | -------- |
| DefaultBatchConfigurer |          |
| **其他**               |          |
| ScopeConfiguration     |          |

## StepRegistry 

```txt

```

| 类              | 描述说明 |
| --------------- | -------- |
| MapStepRegistry |          |

## 其他类

|                   |                    |
| ----------------- | ------------------ |
| JobBuilderFactory | StepBuilderFactory |

# Job

## State

| 类            | 描述说明 |
| ------------- | -------- |
| AbstractState |          |
| SplitState    |          |
| FlowState     |          |
| DecisionState |          |
| StepState     |          |
| EndState      |          |

## AbstractJob

| 类        | 描述说明 |
| --------- | -------- |
| FlowJob   |          |
| SimpleJob |          |

## JobBuilderHelper

| 类               | 描述说明 |
| ---------------- | -------- |
| FlowJobBuilder   |          |
| SimpleJobBuilder |          |
| JobBuilder       |          |

## StepHandler

| 类                | 描述说明 |
| ----------------- | -------- |
| SimpleStepHandler |          |

## FlowExecutor

| 类              | 描述说明 |
| --------------- | -------- |
| JobFlowExecutor |          |

## Flow

| 类         | 描述说明 |
| ---------- | -------- |
| SimpleFlow |          |

## FlowBuilder

```
JobFlowBuilder
```

## FlowExecutionAggregator

| 类                              | 描述说明 |
| ------------------------------- | -------- |
| MaxValueFlowExecutionAggregator |          |

# Launch

## JobLauncher: Job控制台

| 类                | 描述说明 |
| ----------------- | -------- |
| SimpleJobLauncher |          |

## JobOperator

| 类                | 描述说明 |
| ----------------- | -------- |
| SimpleJobOperator |          |

## SystemExiter

| 类              | 描述说明 |
| --------------- | -------- |
| JvmSystemExiter |          |

# Listener

## StepListener

# JobRepository

## JobInstanceDao

## ExecutionContextDao

## AbstractJdbcBatchMetadataDao

## JobExecutionDao

## StepExecutionDao

## JobRepository:star:

# Scope

## 范围管理器

| 类                         | 描述说明             |
| -------------------------- | -------------------- |
| StepSynchronizationManager | 步骤同步化管理器     |
| JobSynchronizationManager  | 作业同步化管理器     |
| JobScopeManager            | 作业范围管理器       |
| StepScopeManager           | 步骤范围管理器       |
| StepContextRepeatCallback  | 步骤上下文重复回调器 |

## 上下文类

| 类           | 描述说明   |
| ------------ | ---------- |
| ChunkContext | 块上下文   |
| StepContext  | 步骤上下文 |
| JobContext   | 作业上下文 |

## 范围

| 类                | 描述说明 |
| ----------------- | -------- |
| BatchScopeSupport |          |
| StepScope         | 步骤范围 |
| JobScope          | 作业范围 |

# Step

## 步骤构建帮助器 :StepBuilderHelper

| 类                   | 描述说明       |
| -------------------- | -------------- |
| PartitionStepBuilder | 分区步骤建造器 |
| FlowStepBuilder      | 流式步骤建造器 |
| StepBuilder          | 步骤建造器     |
| JobStepBuilder       | 作业步骤建造器 |

## Skip策略

| 类                            | 描述说明         |
| ----------------------------- | ---------------- |
| NeverSkipItemSkipPolicy       | 永不跳过策略     |
| CompositeSkipPolicy           | 复合跳过策略     |
| LimitCheckingItemSkipPolicy   | 限制检查跳过策略 |
| ExceptionClassifierSkipPolicy |                  |
| AlwaysSkipItemSkipPolicy      |                  |

## 步骤中断策略:StepInterruptionPolicy

| 类                           | 描述说明 |
| ---------------------------- | -------- |
| ThreadStepInterruptionPolicy |          |

## 小任务Tasklet

| 类                           | 描述说明 |
| ---------------------------- | -------- |
| StoppableTasklet             |          |
| ChunkOrientedTasklet         |          |
| MethodInvokingTaskletAdapter |          |
| CallableTaskletAdapter       |          |

## 系统程序退出码映射器 : SystemProcessExitCodeMapper

| 类                                      | 描述说明 |
| --------------------------------------- | -------- |
| SimpleSystemProcessExitCodeMapper       |          |
| ConfigurableSystemProcessExitCodeMapper |          |

## 批处理重试模板:BatchRetryTemplate

| 类                 | 描述说明 |
| ------------------ | -------- |
| BatchRetryContext  |          |
| InnerRetryTemplate |          |
| BatchRetryState    |          |

## 数据块 Chunk

| 类            | 描述说明 |
| ------------- | -------- |
| ChunkIterator |          |

## 数据块检测器:ChunkMonitor

| 类               | 描述说明 |
| ---------------- | -------- |
| ChunkMonitorData |          |

## 作业参数提取器：JobParametersExtractor

| 类                            | 描述说明 |
| ----------------------------- | -------- |
| DefaultJobParametersExtractor |          |



