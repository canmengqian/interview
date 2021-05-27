## Mongo基本使用

[TOC]

### 基本术语

| SQL术语/概念 | MongoDB术语/概念 | 解释/说明                           |
| ------------ | ---------------- | ----------------------------------- |
| database     | database         | 数据库                              |
| table        | collection       | 数据库表/集合                       |
| row          | document         | 数据记录行/文档                     |
| column       | field            | 数据字段/域                         |
| index        | index            | 索引                                |
| table joins  |                  | 表连接,MongoDB不支持                |
| primary key  | primary key      | 主键,MongoDB自动将_id字段设置为主键 |

### Mongo连接方式

```sq
mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]
mongodb:// 这是固定的格式，必须要指定。

username:password@ 可选项，如果设置，在连接数据库服务器之后，驱动都会尝试登录这个数据库

host1 必须的指定至少一个host, host1 是这个URI唯一要填写的。它指定了要连接服务器的地址。如果要连接复制集，请指定多个主机地址。

portX 可选的指定端口，如果不填，默认为27017

/database 如果指定username:password@，连接并验证登录指定数据库。若不指定，默认打开 test 数据库。

?options 是连接选项。如果不使用/database，则前面需要加上/。所有连接选项都是键值对name=value，键值对之间通过&或;（分号）隔开
```

### Mongo数据类型

- **ObjectId**

    ```sql
    /**ObjectId 是一个12字节 BSON 类型数据，有以下格式：
    
    前4个字节表示时间戳
    接下来的3个字节是机器标识码
    紧接的两个字节由进程id组成（PID）
    最后三个字节是随机数。
    MongoDB中存储的文档必须有一个"_id"键。这个键的值可以是任何类型的，默认是个ObjectId对象。
    
    在一个集合里面，每个文档都有唯一的"_id"值，来确保集合里面每个文档都能被唯一标识。
    */
    -- 生成新的ObjectId：
    newObjectId = ObjectId()
    
    ```

- **基本数据类型**

  | 数据类型           | 描述                                                         |
      | ------------------ | ------------------------------------------------------------ |
  | String             | 字符串。存储数据常用的数据类型。在 MongoDB 中，UTF-8 编码的字符串才是合法的。 |
  | Integer            | 整型数值。用于存储数值。根据你所采用的服务器，可分为 32 位或 64 位。 |
  | Boolean            | 布尔值。用于存储布尔值（真/假）。                            |
  | Double             | 双精度浮点值。用于存储浮点值。                               |
  | Min/Max keys       | 将一个值与 BSON（二进制的 JSON）元素的最低值和最高值相对比。 |
  | Array              | 用于将数组或列表或多个值存储为一个键。                       |
  | Timestamp          | 时间戳。记录文档修改或添加的具体时间。                       |
  | Object             | 用于内嵌文档。                                               |
  | Null               | 用于创建空值。                                               |
  | Symbol             | 符号。该数据类型基本上等同于字符串类型，但不同的是，它一般用于采用特殊符号类型的语言。 |
  | Date               | 日期时间。用 UNIX 时间格式来存储当前日期或时间。你可以指定自己的日期时间：创建 Date 对象，传入年月日信息。 |
  | Object ID          | 对象 ID。用于创建文档的 ID。                                 |
  | Binary Data        | 二进制数据。用于存储二进制数据。                             |
  | Code               | 代码类型。用于在文档中存储 JavaScript 代码。                 |
  | Regular expression | 正则表达式类型。用于存储正则表达式。                         |

### 常用命令

- ##### 创建库和表

    ```shell
    #数据库不存在，则创建数据库，否则切换到指定数据库。
    use DATABASE_NAME
    # 删除当前数据库，默认为 test，你可以使用 db 命令查看当前数据库名。
    db.dropDatabase()
    #查看所有数据库
    show dbs 
    #向数据库插入一些数据。
    db.DB_NAME.insert({"name":"菜鸟教程"})
    ```

- ##### 集合操作

    - **创建集合**

        - ```sql
            db.createCollection(name, options)
            /**
            # 创建集合，类似数据库中的表
            #name: 要创建的集合名称
            #options: 可选参数, 指定有关内存大小及索引的选项
            #capped	布尔	（可选）如果为 true，则创建固定集合。固定集合是指有着固定大小的集合，当达到最大值时，它会自动覆盖最早的文档。
            #当该值为 true 时，必须指定 size 参数。
            #autoIndexId	布尔	3.2 之后不再支持该参数。（可选）如为 true，自动在 _id 字段创建索引。默认为 false。
            #size	数值	（可选）为固定集合指定一个最大值，即字节数。
            #如果 capped 为 true，也需要指定该字段。
            #max	数值	（可选）指定固定集合中包含文档的最大数量。
            */
            
            # 例子: 
            db.createCollection("mycol", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )
            ```

        - ```reStructuredText
            1. 集合名`不能是空字符串`""。
            2. 集合名不能含有\0字符（空字符)，这个字符表示集合名的结尾。
            3. 集合名不能以`"system."`开头，这是为`系统集合`保留的前缀。
            4. 用户创建的集合名字不能含有`保留字符`。有些驱动程序的确支持在集合名里面包含，这是因为某些系统生成的集合中包含该字符。除非你要访问这种系统创建的集合，否则千万不要在名字里出现$。
            ```

        -

    - show collections / show tables 查看集合

    - db.TABLE_NAME.drop()

    - **插入集合**

        - ```sql
            db.COLLECTION_NAME.insert(document) 
            /**
            db.col.insert({title: 'MongoDB 教程', 
                description: 'MongoDB 是一个 Nosql 数据库',
                by: '菜鸟教程',
                url: 'http://www.runoob.com',
                tags: ['mongodb', 'database', 'NoSQL'],
                likes: 100
            })
            */
            db.COLLECTION_NAME.save(document)
            
            /*若插入的数据主键已经存在，则会抛 org.springframework.dao.DuplicateKeyException 异常，提示主键重复，不保存当前数据。*/
            
            -- 批量插入:
            db.collection.insertOne() 和 db.collection.insertMany()
            ```

    - **集合更新**

        - ```sql
            db.collection.update(
               <query>,
               <update>,
               {
                 upsert: <boolean>,
                 multi: <boolean>,
                 writeConcern: <document>
               }
            )
            
            /**
            query : update的查询条件，类似sql update查询内where后面的。
            update : update的对象和一些更新的操作符（如$,$inc...）等，也可以理解为sql update查询内set后面的
            upsert : 可选，这个参数的意思是，如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入。
            multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
            writeConcern :可选，抛出异常的级别。
            */
            
            -- 例子
            db.col.update({'title':'MongoDB 教程'},{$set:{'title':'MongoDB'}})
            ```

    - **集合删除**

        - ```sql
            db.collection.remove(
               <query>,
               {
                 justOne: <boolean>,
                 writeConcern: <document>
               }
            )
            /**
            参数说明：
            
            query :（可选）删除的文档的条件。
            justOne : （可选）如果设为 true 或 1，则只删除一个文档，如果不设置该参数，或使用默认值 false，则删除所有匹配条件的文档。
            writeConcern :（可选）抛出异常的级别。
            */
            ```

        - `remove() 方法已经过时了，现在官方推荐使用 deleteOne() 和 deleteMany() 方法。`

        - `remove() 方法 并不会真正释放空间。需要继续执行 db.repairDatabase() 来回收磁盘空间。`

    - **集合查询**

        - ```sql
            
            db.collection.find(query, projection)
            /**
            query ：可选，使用查询操作符指定查询条件
            projection ：可选，使用投影操作符指定返回的键。查询时返回文档中所有键值， 只需省略该参数即可（默认省略）。
            */
            
            db.col.find().pretty()
            -- pretty() 方法以格式化的方式来显示所有文档。
            
            ```

    - **条件查询**

        - | 操作       | 格式                     | 范例                                        | RDBMS中的类似语句       |
                      | ---------- | ------------------------ | ------------------------------------------- | ----------------------- |
          | 等于       | `{<key>:<value>`}        | `db.col.find({"by":"菜鸟教程"}).pretty()`   | `where by = '菜鸟教程'` |
          | 小于       | `{<key>:{$lt:<value>}}`  | `db.col.find({"likes":{$lt:50}}).pretty()`  | `where likes < 50`      |
          | 小于或等于 | `{<key>:{$lte:<value>}}` | `db.col.find({"likes":{$lte:50}}).pretty()` | `where likes <= 50`     |
          | 大于       | `{<key>:{$gt:<value>}}`  | `db.col.find({"likes":{$gt:50}}).pretty()`  | `where likes > 50`      |
          | 大于或等于 | `{<key>:{$gte:<value>}}` | `db.col.find({"likes":{$gte:50}}).pretty()` | `where likes >= 50`     |
          | 不等于     | `{<key>:{$ne:<value>}}`  | `db.col.find({"likes":{$ne:50}}).pretty()`  | `where likes != 50`     |

        - ```sql
            -- MongoDB AND 查询
            db.col.find({key1:value1, key2:value2}).pretty()
            
            /**
             db.col.find({"by":"菜鸟教程", "title":"MongoDB 教程"}).pretty()
             WHERE by='菜鸟教程' AND title='MongoDB 教程'
            */
            -- MongoDB OR 条件
            db.col.find(
               {
                  $or: [
                     {key1: value1}, {key2:value2}
                  ]
               }
            ).pretty()
            /* db.col.find({$or:[{"by":"菜鸟教程"},{"title": "MongoDB 教程"}]}).pretty()*/
            
            -- AND 和 OR 联合使用
            db.col.find({"likes": {$gt:50}, $or: [{"by": "菜鸟教程"},{"title": "MongoDB 教程"}]}).pretty()
            
            
            ```

    - **Limit与Skip方法**

        - ```SQL
            db.COLLECTION_NAME.find().limit(NUMBER)
            -- limit()方法接受一个数字参数，该参数指定从MongoDB中读取的记录条数。
            db.COLLECTION_NAME.find().limit(NUMBER).skip(NUMBER)
            -- 使用skip()方法跳过指定数量的数据，skip方法同样接受一个数字参数作为跳过的记录条数。
            ```

    - **sort() 方法**

        - ```sql
            /**
            sort() 方法可以通过参数指定排序的字段，并使用 1 和 -1 来指定排序的方式，其中 1 为升序排列，而 -1 是用于降序排列。
            */
            db.COLLECTION_NAME.find().sort({KEY:1})
            ```

    - **MongoDB 聚合**

        - ```sql
            -- 聚合(aggregate)主要用于处理数据(诸如统计平均值,求和等)，并返回计算后的数据结果。有点类似sql语句中的 count(*)。
            db.COLLECTION_NAME.aggregate(AGGREGATE_OPERATION)
            
            -- 例子
            /**
            db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
            */
            
            /**
            $project：修改输入文档的结构。可以用来重命名、增加或删除域，也可以用于创建计算结果以及嵌套文档。
            $match：用于过滤数据，只输出符合条件的文档。$match使用MongoDB的标准查询操作。
            $limit：用来限制MongoDB聚合管道返回的文档数。
            $skip：在聚合管道中跳过指定数量的文档，并返回余下的文档。
            $unwind：将文档中的某一个数组类型字段拆分成多条，每条包含数组中的一个值。
            $group：将集合中的文档分组，可用于统计结果。
            $sort：将输入文档排序后输出。
            $geoNear：输出接近某一地理位置的有序文档。
            */
            
            ```

        - | 表达式    | 描述                                           | 实例                                                         |
                      | --------- | ---------------------------------------------- | ------------------------------------------------------------ |
          | $sum      | 计算总和。                                     | db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : "$likes"}}}]) |
          | $avg      | 计算平均值                                     | db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$avg : "$likes"}}}]) |
          | $min      | 获取集合中所有文档对应值得最小值。             | db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$min : "$likes"}}}]) |
          | $max      | 获取集合中所有文档对应值得最大值。             | db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$max : "$likes"}}}]) |
          | $push     | 在结果文档中插入值到一个数组中。               | db.mycol.aggregate([{$group : {_id : "$by_user", url : {$push: "$url"}}}]) |
          | $addToSet | 在结果文档中插入值到一个数组中，但不创建副本。 | db.mycol.aggregate([{$group : {_id : "$by_user", url : {$addToSet : "$url"}}}]) |
          | $first    | 根据资源文档的排序获取第一个文档数据。         | db.mycol.aggregate([{$group : {_id : "$by_user", first_url : {$first : "$url"}}}]) |
          | $last     | 根据资源文档的排序获取最后一个文档数据         | db.mycol.aggregate([{$group : {_id : "$by_user", last_url : {$last : "$url"}}}]) |

    - **MongoDB 索引**

        - ```sql
            db.collection.createIndex(keys, options)
            -- Key 值为你要创建的索引字段，1 为指定按升序创建索引，如果你想按降序来创建索引指定为 -1 即可。
            
            ```

        - | Parameter          | Type          | Description                                                  |
                      | ------------------ | ------------- | ------------------------------------------------------------ |
          | background         | Boolean       | 建索引过程会阻塞其它数据库操作，background可指定以后台方式创建索引，即增加 "background" 可选参数。 "background" 默认值为**
          false**。 |
          | unique             | Boolean       | 建立的索引是否唯一。指定为true创建唯一索引。默认值为**false**. |
          | name               | string        | 索引的名称。如果未指定，MongoDB的通过连接索引的字段名和排序顺序生成一个索引名称 |
          | sparse             | Boolean       | 对文档中不存在的字段数据不启用索引；这个参数需要特别注意，如果设置为true的话，在索引字段中不会查询出不包含对应字段的文档.。默认值为 **
          false**. |
          | expireAfterSeconds | integer       | 指定一个以秒为单位的数值，完成 TTL设定，设定集合的生存时间。 |
          | v                  | index version | 索引的版本号。默认的索引版本取决于mongod创建索引时运行的版本。 |
          | weights            | document      | 索引权重值，数值在 1 到 99,999 之间，表示该索引相对于其他索引字段的得分权重。 |
          | default_language   | string        | 对于文本索引，该参数决定了停用词及词干和词器的规则的列表。 默认为英语 |
          | language_override  | string        | 对于文本索引，该参数指定了包含在文档中的字段名，语言覆盖默认的language，默认值为 language. |

### Mongo关系处理

- MongoDB 中的关系可以是：

```reStructuredText
 1:1 (1对1)
 1: N (1对多)
 N: 1 (多对1)
 N: N (多对多)
```

- 建立关系方式

    - ```sql
        -- 嵌入式关系
        {
           "_id":ObjectId("52ffc33cd85242f436000001"),
           "contact": "987654321",
           "dob": "01-01-1991",
           "name": "Tom Benzamin",
           "address": [
              {
                 "building": "22 A, Indiana Apt",
                 "pincode": 123456,
                 "city": "Los Angeles",
                 "state": "California"
              },
              {
                 "building": "170 A, Acropolis Apt",
                 "pincode": 456789,
                 "city": "Chicago",
                 "state": "Illinois"
              }]
        } 
        ```

    - ```sql
        -- 引用式关系
        引用式关系{
           "_id":ObjectId("52ffc33cd85242f436000001"),
           "contact": "987654321",
           "dob": "01-01-1991",
           "name": "Tom Benzamin",
           "address_ids": [
              ObjectId("52ffc4a5d85242602e000000"),
              ObjectId("52ffc4a5d85242602e000001")
           ]
        }
        ```

        