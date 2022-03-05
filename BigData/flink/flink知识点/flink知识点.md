[TOC]

# [概念透析](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/concepts/overview/) 

## [Flink 中的 API](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/concepts/overview/#flink-%e4%b8%ad%e7%9a%84-api)

# Flink架构

## [Flink 集群剖析](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/concepts/flink-architecture/#flink-%e9%9b%86%e7%be%a4%e5%89%96%e6%9e%90)

# Flink问题集

## Job&Task

- [查询Job指标](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/try-flink/flink-operations-playground/#%E6%9F%A5%E8%AF%A2-job-%E6%8C%87%E6%A0%87)
- [REST API](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/ops/rest_api/#api)

## Checkpoint & SavePoint

## 反压监控

## 指标

### 网络指标

- [网络指标](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/ops/metrics/#default-shuffle-service)

## 流计算

- [实践练习](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/learn-flink/overview/)
- [DataStream API 简介](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/learn-flink/datastream_api/)
  - 练习项目: https://github.com/apache/flink-training/tree/release-1.13/ride-cleansing
  - 练习库: https://github.com/apache/flink-training/tree/release-1.13/

- 管道计算&ETL

  - KEY无状态的转换

  - KEY有状态的转换

    - ```java
      RichFlatMapFunction
      TODO : ValueState
      ValueStateDescriptor
      ```

  - Non-keyed State 

  - [练习项目](https://github.com/apache/flink-training/tree/release-1.13/rides-and-fares)

- [事件时间& watermarks](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/learn-flink/streaming_analytics/)

- [窗口函数](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/learn-flink/streaming_analytics/)
  - [窗口函数练习](https://github.com/apache/flink-training/tree/release-1.13/hourly-tips)

- 有状态流处理

# 事件驱动应用

## 处理函数（Process Functions）

## 旁路输出（Side Outputs）

# 快照实现容错处理

# 相关的API

## [DataStream API](https://ci.apache.org/projects/flink/flink-docs-release-1.13/zh/docs/dev/datastream/overview/)

