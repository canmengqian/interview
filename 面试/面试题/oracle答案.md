# Oracle

1. oracle 内部访问路径有哪些 ?
    1. TABLE ACCESS FULL
    2. TABLE ACCESS BY USER ROWID
    3. TABLE ACCESS BY ROWID RANGE
    4. TABLE ACCESS BY INDEX ROWID
    5. INDEX UNIQUE SCAN
    6. INDEX RANGE SCAN
    7. INDEX SKIP SCAN
    8. INDEX FULL SCAN
    9. INDEX FULL SCAN(MIN/MAX)
    10. INDEX FAST FULL SCAN
    11. MAT VIEW  REWRITE ACCESS FULL 
2. oracle 内部表连接方式
    1.  嵌套循环
    2. Hash JOIN 
    3. 排序合并
    4. 笛卡尔积
    5. 标量子查询
    6. 半连接
    7. 反连接
    8. Filter

3. 常用SQL调优方式
    1. 使用UNION 替换OR
    2. 减少标量子查询
    3. 建立索引时添加索引排序机制，避免ORDER BY
    4. 尽量避免WHERE 左侧使用 函数
    5. 使用临时表 替代多次查询
    6. 选择性使用IN，基数不高时可选用IN查询
    7. 使用HINT强制走索引,添加并行语句
    8. 物理空间足够下,简单查询使用分区表[范围分区,hash分区,列表分区,子分区]
    9. 尽量避免使用 * ,只查询必要字段
4. 什么场景下使用SQL并行度