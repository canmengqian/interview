## Elasticsearch入门

[TOC]

### 基本概念

- **节点** - 它指的是Elasticsearch的单个正在运行的实例。单个物理和虚拟服务器容纳多个节点，这取决于其物理资源的能力，如RAM，存储和处理能力。
- **集群** - 它是一个或多个节点的集合。 集群为整个数据提供跨所有节点的集合索引和搜索功能。
- **索引** - 它是不同类型的文档和文档属性的集合。索引还使用分片的概念来提高性能。 例如，一组文档包含社交网络应用的数据。
- **类型/映射** - 它是共享同一索引中存在的一组公共字段的文档的集合。 例如，索引包含社交网络应用的数据，然后它可以存在用于用户简档数据的特定类型，另一类型可用于消息的数据，以及另一类型可用于评论的数据。
- **文档** - 它是以JSON格式定义的特定方式的字段集合。每个文档都属于一个类型并驻留在索引中。每个文档都与唯一标识符(称为UID)相关联。
- **碎片** - 索引被水平细分为碎片。这意味着每个碎片包含文档的所有属性，但包含的数量比索引少。水平分隔使碎片成为一个独立的节点，可以存储在任何节点中。主碎片是索引的原始水平部分，然后这些主碎片被复制到副本碎片中。
- **副本** - Elasticsearch允许用户创建其索引和分片的副本。 复制不仅有助于在故障情况下增加数据的可用性，而且还通过在这些副本中执行并行搜索操作来提高搜索的性能。

### ES简单的增删改查

#### 创建一篇文档（有则修改，无则创建)

- ```json
  PUT test/doc/2
  {
    "name":"wangfei",
    "age":27,
    "desc":"热天还不让后人不认同"
  }
  
  PUT test/doc/1
  {
    "name":"wangjifei",
    "age":27,
    "desc":"萨芬我反胃为范围额"
  }
  
  PUT test/doc/3
  {
    "name":"wangyang",
    "age":30,
    "desc":"点在我心内的几首歌"
  }
  ```

#### 查询[文档、索引]

##### 查询指定索引信息

- ```json
  GET test
  ```

##### 查询指定文档信息

- ```json
  GET test/doc/1
  GET test/doc/2
  ```

##### search 关键字

```json
GET test/doc/_search
或
GET test/doc/_search
{
  "query": {
    "match_all": {}
  }
}
```

```json
// URL带上查询字段
GET test/doc/_search?q=name:wangfei
```

##### 使用match表达式

- **简单匹配**

```json
//match系列之match_all (查询全部)
GET test/doc/_search
{
  "query":{
    "match_all": {
    }
  }
}
```

```json
// 准备另一组数据

PUT test1/doc/1
{
  "title": "中国是世界上人口最多的国家"
}
PUT test1/doc/2
{
  "title": "美国是世界上军事实力最强大的国家"
}
PUT test1/doc/3
{
  "title": "北京是中国的首都"
}

```

- **简单查询**

  ES本身不支持中文,查询返回了中国的文档。但是却把和美国的文档也返回，因为这是elasticsearch在内部对文档做分词的时候，对于中文来说，就**是一个字一个字分**
  的，所以，我们搜中国，中和国都符合条件，返回，而美国的国也符合。而我们认为中国是个短语，是一个有具体含义的词。所以elasticsearch在处理中文分词方面比较弱势。后面会讲针对**中文的插件**
  。但目前我们还有办法解决，那就是使用短语查询 用**match_phrase**

  ```
  GET test1/doc/_search
  {
    "query":{
      "match":{
        "title":"中国"
      }
    }
  }
  ```

- **使用slop做间隔查询**。相当于正则中的中国.*?世界。这个间隔默认为0

  ```json
  POST test1/doc/_search
  {
    "query":{
      "match_phrase": {
        "title": {
          "query": "中国世界",
          "slop":2
        }
      }
    }
  }
  ```

- #### **match_phrase_prefix（最左前缀查询）**

  ```json
  //数据准备
  
  PUT test2/doc/1
  {
    "title": "prefix1",
    "desc": "beautiful girl you are beautiful so"
  }
  
  PUT test2/doc/2
  {
    "title": "beautiful",
    "desc": "I like basking on the beach"
  }
  
  // 搜索特定英文开头的数据
  GET test2/doc/_search
  {
    "query": {
      "match_phrase_prefix": {
        "desc": "bea"
      }
    }
  }
  ```

- ##### max_expansions 参数理解 前缀查询会非常的影响性能，要对结果集进行限制

  ```json
  GET test2/doc/_search
  {
    "query": {
      "match_phrase_prefix": {
        "desc": {
          "query": "bea",
          "max_expansions":1
        }
      }
    }
  }
  ```

- #### multi_match（多字段查询)

  ```json
  GET test2/doc/_search
  {
    "query": {
      "multi_match": {
        "query": "beautiful",
        "fields": ["title","desc"]
      }
    }
  }
  ```

#### 排序

- 降序排序

  ```json
  GET test/doc/_search
  {
    "query": {
      "match_all": {}
    },
    "sort": [
      {
        "age": {
          "order": "desc"
        }
      }
    ]
  }
  ```

- 升序排序

  ```json
  GET test/doc/_search
  {
    "query": {
      "match_all": {}
    },
    "sort": [
      {
        "age": {
          "order": "asc"
        }
      }
    ]
  }
  ```

#### 分页查询

- ```json
  GET test/doc/_search
  {
    "query": {
      "match_phrase_prefix": {
        "name": "wang"
      }
    },
    "from": 0,
    "size": 1
  }
  ```

#### 逻辑查询

- **Must查询**: (must字段对应的是个列表，也就是说可以有多个并列的查询条件，一个文档满足各个子条件后才最终返回)，**相当于AND**

  ```json
  #### 单条件查询
  GET test/doc/_search
  {
    "query": {
      "bool": {
        "must": [
          {
            "match": {
            "name": "wangfei"
            }
          }
        ]
      }
    }
  }
  
  #### 多条件组合查询
  GET test/doc/_search
  {
    "query": {
      "bool": {
        "must": [
          {
            "match": {
              "name": "wanggfei"
            }
          },{
            "match": {
              "age": 25
            }
          }
        ]
      }
    }
  }
  ```

- **should查询:** (只要符合其中一个条件就返回),**相当于OR**

  ```json
  GET test/doc/_search
  {
    "query": {
      "bool": {
        "should": [
          {
            "match": {
            "name": "wangjifei"
          }
          },{
            "match": {
              "age": 27
            }
          }
        ]
      }
    }
  }
  ```

- **filter(条件过滤查询**，过滤条件的范围用range表示gt表示大于、lt表示小于、gte表示大于等于、lte表示小于等于)

  ```json
  GET test/doc/_search
  {
    "query": {
      "bool": {
        "must": [
          {
            "match": {
              "name": "wangjifei"
            }
          }
        ],
        "filter": {
          "range": {
            "age": {
              "gte": 10,
              "lt": 27
            }
          }
        }
      }
    }
  }
  ```

#### 高亮查询

- ```json
  ####准备数据
  
  PUT test3/doc/1
  {
    "name":"顾老二",
    "age":30,
    "from": "gu",
    "desc": "皮肤黑、武器长、性格直",
    "tags": ["黑", "长", "直"]
  }
  ```

  ```json
  GET test3/doc/_search
  {
    "query": {
      "match": {
        "name": "顾老二"
      }
    },
    "highlight": {
      "fields": {
        "name": {}
      }
    }
  }
  ```

#### ES之精确查询与模糊查询

#### ES的聚合查询avg、max、min、sum

#### ES的分组查询

#### ES之Mappings

#### 删除 文档,索引

- ```json
  DELETE test/doc/3 //删除指定文档
  DELETE test //删除索引
  ```

#### 修改 文档

- ```json
  PUT test/doc/1
  {
    "name":"王计飞"
  }
  // 其他属性完全消失,慎用
  ```

- **更新指定属性,属性不存在会报错**

  ```json
  POST test/doc/1/_update
  {
    "doc":{
      "desc":"生活就像 茫茫海上"
    }
  }
  ```

### 参照文档

- [www.bootwiki.com](https://www.bootwiki.com/elasticsearch/elasticsearch-mapping.html)

- [ElasticSearch Head插件]()
- [sense插件]()
- [APIDebug]()
- [ES学习教程](https://www.jianshu.com/p/3873a6290c65)

- [elasticsearch 学习笔记01](https://www.jianshu.com/p/934e62748743)
- [ElasticSearch学习笔记(1)——基本语法](https://www.jianshu.com/p/3ea25ef41088)

