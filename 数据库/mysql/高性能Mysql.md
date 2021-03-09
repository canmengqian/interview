# 高性能Mysql

1. LVS
2. 中继日志
3. INSERT INTO summary_table(col1, col2, sum_col3)
4. 执行计划
5. 基于行的复制模式和基于语句的复制当第一个备库将从主库获得的事件写入到其二进制日志中时，这个事件在备库二进制日志中的位置与其在主库二进制日志中的位置几乎肯定是不相同的，可能在不同的日志文件或文件内不同的位置
6. 确定主备是否一致，pt-table-checksum
7. 联机事务处理（OLTP）
8. 预写日志（WAL）策略
9. RAID
10. 参数设置【】
11. 优化服务器设置
12. 通过基准测试迭代优化
13. mysql监测
14. 分区表的数据可以分布在不同的物理设备上，从而高效地利用多个硬件设备

| slave_exec_mode            | key_buffer_size   |
| -------------------------- | ----------------- |
| expire_logs_days           | table_cache_size  |
| log_slave_updates          | thread_cache_size |
| binlog_do_db               | query_cache_size  |
| binlog_ignore_db           | read_buffer_size  |
| read_rnd_buffer_size       | sort_buffer_size  |
| tmp_table_size             |                   |
| innodb_max_dirty_pages_pct |                   |
| innodb_thread_concurrency  |                   |
| innodb_thread_sleep_delay  |                   |
| innodb_concurrency_tickets |                   |
| innodb_commit_concurrency  |                   |
| tmp_table_size             |                   |
| max_heap_table_size        |                   |
| max_connections            |                   |

文章要素

是什么

为什么(优缺点)+论证(影响的因素点)

对比点

怎么做(实战和优化)

其余方向扩展

引用