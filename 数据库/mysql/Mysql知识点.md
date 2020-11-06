# Mysql知识点

[TOC]

## Sql常用优化点

1.  **避免全表扫描**，对查询进行优化，应尽量避免全表扫描，首先应考虑在 **where 及 order by 涉及的列上建立索引**
2. **避免查询条件中字段计算**,不要在 where 子句中的“=”左边进行函数、算术运算或其他表达式运算，否则系统将可能无法正确使用索引
3. **避免判断null值**,应尽量避免在 where 子句中对字段进行 null 值判断，否则将导致引擎放弃使用索引而进行全表扫描，
4. **避免不等值判断**,应尽量避免在 where 子句中使用!=或<>操作符，否则引擎将放弃使用索引而进行全表扫描。
5. **避免使用or逻辑**，应尽量避免在 where 子句中使用 or 来连接条件，否则将导致引擎放弃使用索引而进行全表扫描
6. 尽量使用数字型字段，若只含数值信息的字段尽量不要设计为字符型，因为这会降低查询和连接的性能，并会增加存储开销。这是因为引擎在处理查询和连接时会逐个比较字符串中每一个字符，而对于数字型而言只需要比较一次就够了。
7. 尽量使用 varchar 代替 char ，因为首先可变长度字段存储空间小，可以节省存储空间，其次对于查询来说，在一个相对较小的字段内搜索效率显然要高些。
8. 慎用in和not in逻辑，否则会导致全表扫描。子查询最好能够改写成多表关联

## 索引

索引的类型

索引失效，索引优化

# 

## 链接

1. [mysql四大排名函数(row_number、rank、dense_rank、ntile)使用简介](https://blog.csdn.net/qq_31476455/article/details/90028819)
2. [MySQL case when 用法](https://www.cnblogs.com/chenduzizhong/p/9590741.html)
3. [50道SQL练习题及答案与详细分析](https://www.jianshu.com/p/476b52ee4f1b)
4. [面试 SQL整理 常见的SQL面试题：经典50题](https://blog.csdn.net/u010565545/article/details/100785261#%E5%B8%B8%E8%A7%81%E7%9A%84SQL%E9%9D%A2%E8%AF%95%E9%A2%98%EF%BC%9A%E7%BB%8F%E5%85%B850%E9%A2%98)

SQL优化

索引，最左原则

springMVC的运行流程

Spring怎么实现事务管理

Spring 的单例是安全的吗

注入方式有哪些

Spring AOP

${}和#{}区别

redis集群搭建

redis基本数据类型

Servlet 中filter 的request请求会不会被丢弃