# spark知识点

## Spark生态

- Spark将数据在分布式环境下分区，然后将作业转化为有向无环图（DAG），并分阶段进行DAG的调度和任务的分布式并行处理。
- 可以在Spark上直接书写SQL，相当于为Spark扩充了一套SQL算子，这无疑更加丰富了Spark的算子和功能。同时Spark SQL不断兼容不同的持久化存储（如HDFS、Hive等）
- Spark Streaming通过将流数据按指定时间片累积为RDD，然后将每个RDD进行批处理，进而实现大规模的流数据处理。其吞吐量能够超越现有主流流处理框架Storm，并提供丰富的API用于流数据计算。