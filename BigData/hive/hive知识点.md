# hive知识点

[TOC]

## 数据库相关操作

### 创建一个数据库

- ```sql
  CREATE DATABASE IF NOT EXISTS financials COMMENT 'Holds all financial tables';
  ```

- #### **指定数据库存储位置**

  ```sql
  CREATE DATABASE financials LOCATION '/my/preferred/directory';
  ```

- #### **设置数据库相关属性**

  ```sql
  CREATE DATABASE financials WITH DBPROPERTIES ('creator' = 'Mark Moneybags', 'date' = '2012-01-02');
  -- 查看数据库相关属性
  DESCRIBE DATABASE EXTENDED financials;
  ```

### 删除和修改数据库

- **级联删除数据库**

  ```sql
  -- 先删除数据库中的表，然后再删除数据库
  DROP DATABASE IF EXISTS financials CASCADE;
  ```

- 修改数据库属性

  ```sql
  ALTER DATABASE financials SET DBPROPERTIES ('edited-by' = 'Joe Dba');
  ```

## 表相关操作

### 创建表

#### 普通建表语句

```sql
CREATE TABLE IF NOT EXISTS mydb.employees (
　name　　　　　　　STRING COMMENT 'Employee name',
　salary　　　　　　FLOAT COMMENT 'Employee salary',
　subordinates　　　ARRAY<STRING> COMMENT 'Names of subordinates',
　deductions　　　　MAP<STRING, FLOAT>
　　　　　　　　　　 COMMENT 'Keys are deductions names, values are percentages',
　address　　　　　　STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
COMMENT 'Home address')
COMMENT 'Description of the table'
TBLPROPERTIES ('creator'='me', 'created_at'='2012-01-02 10:00:00', ...)
LOCATION '/user/hive/warehouse/mydb.db/employees';

-- TBLPROPERTIES 指定表属性
-- LOCATION 指定表存储位置
```

#### 外部表创建语句

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS stocks (
　exchange　　　　　STRING,
　symbol　　　　　　STRING,
　ymd　　　　　　　  STRING,
　price_open　　　　FLOAT,
　price_high　　　　FLOAT,
　price_low　　　　 FLOAT,
　price_close　　　 FLOAT,
　volume　　　　　　INT,
　price_adj_close FLOAT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/data/stocks';
```

#### 创建分区表和外部分区表

```sql
CREATE TABLE employees (
　name　　　　　　　STRING,
　salary　　　　　　FLOAT,
　subordinates 　　ARRAY<STRING>,
　deductions 　　　 MAP<STRING, FLOAT>,
　address 　　　　　STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
)
PARTITIONED BY (country STRING, state STRING);
-- 查看表中存在的所有分区
SHOW PARTITIONS
-- 查看特定分区
SHOW PARTITIONS employees PARTITION(country='US', state='AK');
```

#### 复制表结构

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS mydb.employees3
LIKE mydb.employees
LOCATION '/path/to/data';
```

#### 内部表和外部表的区别

​	Hive默认情况下会将这些表的数据存储在由配置项hive.metastore.warehouse.dir（例如，/user/hive/warehouse）所定义的目录的子目录下。当我们删除一个管理表时，Hive也**会删除这个表中数据**。表是外部的，所以H**ive并非认为其完全拥有这份数据**。因此，删除该表并不会删除掉这份数据，不过描述表的**元数据信息**会被删除掉

### 表信息查询

```sql
-- 使用FORMATTED关键字替代EXTENDED关键字的话，可以提供更加可读的和冗长的输出信息
DESCRIBE EXTENDED mydb.employees;
```

### 删除表

```sql
DROP TABLE IF EXISTS employees;
/**
如果用户开启了Hadoop回收站功能（这个功能默认是关闭的），那么数据将会被转移到用户在分布式文件系统中的用户根目录下的.Trash目录下，也就是HDFS中的/user/$USER/.Trash目录。如果想开启这个功能，只需要将配置属性fs.trash.interval的值设置为一个合理的正整数即可。这个值是“回收站检查点”间的时间间隔，单位是分钟。因此如果设置值为1440，那么就表示是24小时。
**/
```

### 修改表

#### 表重命名

```sql
ALTER TABLE log_messages RENAME TO logmsgs;
```

#### 增加、修改和删除表分区

```sql
-- ALTER TABLE table ADD PARTITION … 语句用于为表（通常是外部表）增加一个新的分区。
--移动位置来修改某个分区的路径，命令不会将数据从旧的路径转移走，也不会删除旧的数据。
ALTER TABLE log_messages PARTITION(year = 2011, month = 12, day = 2)
SET LOCATION 's3n://ourbucket/logs/2011/01/02';
-- 删除某个分区
ALTER TABLE log_messages DROP IF EXISTS PARTITION(year = 2011, month = 12, day = 2);
```

#### 修改列信息

```sql
-- 增加列
ALTER TABLE log_messages ADD COLUMNS (
　app_name  STRING COMMENT 'Application name',
　session_id LONG  COMMENT 'The current session id');
-- 替换列
ALTER TABLE log_messages REPLACE COLUMNS (
　hours_mins_secs INT  COMMENT 'hour, minute, seconds from timestamp',
　severity 　　　　STRING COMMENT 'The message severity'
　　message 　　　　STRING COMMENT 'The rest of the message');
--修改并移动列
ALTER TABLE log_messages
CHANGE COLUMN hms hours_minutes_seconds INT
COMMENT 'The hours, minutes, and seconds part of the timestamp'
AFTER severity;
```

## 数据导入与导出

### 通过load语句导入数据

```sql
/**
1.分区目录不存在的话，这个命令会先创建分区目录，然后再将数据拷贝到该目录下.如果目标表是非分区表，那么语句中应该省略PARTITION子句。
2.用户指定了OVERWRITE关键字，那么目标文件夹中之前存在的数据将会被先删除掉。如果没有这个关键字，仅仅会把新增的文件增加到目标文件夹中而不会删除之前的数据。然而，如果目标文件夹中已经存在和装载的文件同名的文件，那么旧的同名文件将会被覆盖重写。
*/
LOAD DATA (LOCAL) INPATH '${env:HOME}/california-employees'
OVERWRITE INTO TABLE employees
PARTITION (country = 'US', state = 'CA');

```

### 通过查询语句向表中插入数据

```sql
/**
1.用了OVERWRITE关键字，因此之前分区中的内容（如果是非分区表，就是之前表中的内容）将会被覆盖掉
2.没有使用OVERWRITE关键字或者使用INTO关键字替换掉它的话，那么Hive将会以追加的方式写入数据而不会覆盖掉之前已经存在的内容。
*/
INSERT OVERWRITE TABLE employees
PARTITION (country = 'US', state = 'OR')
SELECT * FROM staged_employees se
WHERE se.cnty = 'US' AND se.st = 'OR';
```

### 导出数据

```sql
INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT name, salary, address
FROM employees
WHERE se.state = 'CA';
```

## Hive优化

### Hive优化点

- 使用分区字段对表进行分区操作

  ```reStructuredText
  MapReduce会将一个任务（job）转换成多个任务（task）。默认情况下，每个task都是一个新的JVM实例，都需要开启和销毁的开销。对于小文件，每个文件都会对应一个task。在一些情况下，JVM开启和销毁的时间中销毁可能会比实际处理数据的时间消耗要长！因此，一个理想的分区方案不应该导致产生太多的分区和文件夹目录，并且每个目录下的文件应该足够得大，应该是文件系统中块大小的若干倍。
  ```

- 使用Hash算法进行分桶操作

- 使用序列化和压缩算法

- 对hive属性进行调优

  | 属性                                 |                                    |
  | ------------------------------------ | ---------------------------------- |
  | hive.limit.optimize.enable           |                                    |
  | hive.limit.row.max.size              |                                    |
  | hive.limit.optimize.limit.file       |                                    |
  | hive.exec.parallel                   | 开启并发执行                       |
  | hive.exec.reducers.bytes.per.reducer |                                    |
  | mapred.reduce.tasks                  |                                    |
  | hive.exec.reducers.max               |                                    |
  | mapred.job.reuse.jvm.num.tasks       | 用于小文件的场景或task特别多的场景 |
  | hive.exec.compress. intermediate     | 开启中间压缩                       |

  

- JVM属性调优

- 推测执行

- 多表关联下,对join进行优化

  ​	如果所有表中有一个**表足够得小**，是可以完成载入到内存中的，那么这时Hive可以执行一个**map-side JOIN**，这样可以减少reduce过程，有时甚至可以减少某些**map task任务**。有时候即使某些表不适合载入内存也可以使用mapJOIN，因为减少reduce阶段可能比将不太大的表分发到每个map task中会带来更多的好处。