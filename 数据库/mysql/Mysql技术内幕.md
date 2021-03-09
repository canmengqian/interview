# Mysql技术内幕

- 官方参考文档 http://www.searchdoc.cn/rdbms/mysql/dev.mysql.com/doc/refman/5.7/en/innodb-buffer-pool-stats-table.com.coder114.cn.html
- Checkpoint的机制
- 缓冲池中缓存的数据页类型
- 允许有多个缓冲池实例。每个页根据哈希值平均分配到不同缓冲池实例中。
- 压缩页,unzip_LRU 
- 伙伴算法
- 脏页
- 重做日志缓冲 ，Write Ahead Log策略
- 共享表空间,试图通过独立表空间ibd文件恢复表中数据时，往往会导致CHECK TABLE失败。所以通过ibd文件进行恢复后，还需要进行REPAIR TABLE操作来重建表上所有的辅助索引。
- 如果发现系统在高峰时的Innodb_dblwr_pages_written:Innodb_dblwr_writes远小于64∶1，那么可以说明系统写入压力并不是很高
- 刷新邻接页
- 错误日志（error log）二进制日志（binlog）❑慢查询日志（slow query log）❑查询日志（log）
- mysqldumpslow,mysqlbinlog
- 慢日志: general_log，slow_log
- INSERT DELAY语句。
- 表结构定义文件frm
- 索引组织表
- InnoDB逻辑存储结构
- 启用了innodb_file_per_table的参数，需要注意的是每张表的表空间内存放的只是数据、索引和插入缓冲Bitmap页，其他类的数据，如回滚（undo）信息，插入缓冲索引页、系统事务信息，二次写缓冲（Double write buffer）等还是存放在原来的共享表空间内
- infobright
- InnoDB数据页。
- 空闲链表
- 稀疏目录（sparse directory）
- 如果用户想通过约束对于数据库非法数据的插入或更新，即MySQL数据库提示报错而不是警告，那么用户必须设置参数sql_mode，用来严格审核输入的参数
- 物化视图
- EXPLAIN PARTITION命令
- NDB Cluster引擎
- 页锁，行级锁,
- 一致性非锁定读，一致性锁定读
- gap lock
- 隐式提交的SQL语句
- 数据库都提供了group commit的功能，即一次fsync可以刷新确保多个事务日志被写入文件
- 

```sql
	SHOW ENGINE INNODB STATUS; -- 查看缓冲池指标
	
	
```

- #### Mysql参数优化

| 配置和说明                                                   |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| innodb_flush_log_at_trx_commit                               |                                                              |
| innodb_buffer_pool_size                                      | IBUF_POOL_SIZE_PER_MAX_SIZE=3，最大只能使用1/3的缓冲池内存   |
| innodb_buffer_pool_instances   配置缓冲池实例                | innodb_change_buffer_max_size控制Change Buffer最大使用内存的数量：innodb_change_buffer_max_size值默认为25，<br>表示最多使用1/4的缓冲池内存空间，该参数的最大有效值为50 |
| innodb_old_blocks_pct 使用LRU算法时的折中块位置              | innodb_change_buffering，用来开启各种Buffer的选项。<br>该参数可选的值为：inserts、deletes、purges、changes、all、none。inserts、deletes |
| innodb_old_blocks_time 页读取到mid位置后需要等待多久才会被加入到LRU列表的热端 | innodb_adaptive_hash_index  启用hash索引                     |
| innodb_log_buffer_size  重做日志缓冲池大小                   | innodb_flush_neighbors，用来控制是否启用刷新邻接页           |
| innodb_fast_shutdown Sharp/Fuzz Checkpoint                   | innodb_fast_shutdown 定义mysql关机模式                       |
| innodb_lru_scan_depth                                        | innodb_force_recovery mysql恢复模式                          |
| binlog_cache_size                                            |                                                              |
| read_buffer_size                                             |                                                              |
| **二进制日志文件相关**                                       |                                                              |
| binlog_format ROW<br/>binlog_group_commit_sync_delay 0<br/>binlog_group_commit_sync_no_delay_count 0<br/>binlog_gtid_simple_recovery ON<br/>binlog_max_flush_queue_time 0<br/>binlog_order_commits ON<br/>binlog_rotate_encryption_master_key_at_startup OFF<br/>binlog_row_event_max_size 8192<br/>binlog_row_image FULL<br/>binlog_row_metadata MINIMAL<br/> | binlog_row_value_options <br/>binlog_rows_query_log_events OFF<br/>binlog_stmt_cache_size 32768<br/>binlog_transaction_compression OFF<br/>binlog_transaction_compression_level_zstd 3<br/>binlog_transaction_dependency_history_size 25000<br/>binlog_transaction_dependency_tracking COMMIT_ORDER<br/>max_binlog_size<br/>binlog_cache_size<br/>sync_binlog<br/>binlog-do-db<br/>binlog-ignore-db<br/>log-slave-update |
| 重做日志                                                     |                                                              |
| innodb_support_xa                                            |                                                              |
| transaction-isolation                                        |                                                              |
| innodb_locks_unsafe_for_binlog                               |                                                              |
| innodb_purge_batch_size                                      |                                                              |
| innodb_max_purge_lag                                         |                                                              |
| innodb_max_purge_lag_delay                                   |                                                              |
|                                                              |                                                              |
|                                                              |                                                              |
|                                                              |                                                              |
|                                                              |                                                              |
|                                                              |                                                              |
|                                                              |                                                              |
|                                                              |                                                              |

