[TOC]

# 功能概要

- 属性或字段访问,构造器访问,变量访问,(公开,静态)方法访问
- 安全访问
- 访问数组下标,Map下标,属性下标,集合下标,字符串下标
- 访问列表,Bean对象,Map
- 基础操作
  - 文本,数字(boolean,long,int,float,null,Real)提取
  - 数学表达式 ： 加[字符串,数字,日期],减[数字,日期],乘,除,取余,自增,平方
  - 逻辑表达式 : AND , OR ，NOT
  - 比较操作: GE,LE,NE,EQ,GT,LT, Between
  - 对象比较: Instance of 
  - 三目操作(ternary),简化三目运算[Elvis]
  - 混合表达式(CompoundExpression)
  - 赋值操作

# Package 主要类

## SpelNode：spel节点 抽象语法树

| 类名                       | 描述                        |      |
| -------------------------- | --------------------------- | ---- |
| SpelNodeImpl               |                             |      |
| Identifier                 | 标识符                      |      |
| Selection                  | 对当前对象,集合,map进行选中 |      |
| QualifiedIdentifier        |                             |      |
| **类型引用**               |                             |      |
| TypeReference              | 类型引用                    |      |
| MethodReference            |                             |      |
| VariableReference          |                             |      |
| FunctionReference          |                             |      |
| ConstructorReference       |                             |      |
| PropertyOrFieldReference   |                             |      |
| BeanReference              |                             |      |
| **其他计算**               |                             |      |
| CompoundExpression         | 混合表达式                  |      |
| Assign                     |                             |      |
| Elvis                      | 简化三目                    |      |
| Ternary                    | 三目操作                    |      |
| **索引操作**               |                             |      |
| Indexer                    |                             |      |
| ArrayIndexingValueRef      |                             |      |
| MapIndexingValueRef        |                             |      |
| PropertyIndexingValueRef   |                             |      |
| CollectionIndexingValueRef |                             |      |
| StringIndexingLValue       |                             |      |
| **Value引用**              |                             |      |
| ValueRef                   |                             |      |
| NullValueRef               |                             |      |
| TypedValueHolderValueRef   |                             |      |
| MethodValueRef             |                             |      |
| **内联操作**               |                             |      |
| InlineMap                  | 内联map                     |      |
| InlineList                 | 内联集合                    |      |
| **逻辑操作**               |                             |      |

## PropertyAccessor：属性访问器

```java
属性访问器能够读取（并可能写入）对象的属性。
这个接口没有任何限制，因此实现者可以自由地直接作为字段或通过 getter 或以他们认为合适的任何其他方式访问属性。
解析器可以选择性地指定应为其调用的目标类数组。 但是，如果它从getSpecificTargetClasses()返回null ，它将为所有属性引用调用，并有机会确定它是否可以读取或写入它们。
属性解析器被认为是有序的，每个解析器将被依次调用。 影响调用顺序的唯一规则是任何直接在getSpecificTargetClasses()命名目标类的解析器将在通用解析器之前首先被调用
```

| 类                         | 说明 |      |
| -------------------------- | ---- | ---- |
| CompilablePropertyAccessor |      |      |
| ReflectivePropertyAccessor |      |      |

## ExpressionException:表达式异常

| 类                                  | 说明 |      |
| ----------------------------------- | ---- | ---- |
| EvaluationException                 |      |      |
| SpelEvaluationException             |      |      |
| ExpressionInvocationTargetException |      |      |
| ParseException                      |      |      |
| SpelParseException                  |      |      |

## ExpressionParser:表达式解析器

| 类                            | 说明 |      |
| ----------------------------- | ---- | ---- |
| TemplateAwareExpressionParser |      |      |
| SpelExpressionParser          |      |      |
| InternalSpelExpressionParser  |      |      |

## ParserContext:解析上下文

| 类                    | 说明 |      |
| --------------------- | ---- | ---- |
| TemplateParserContext |      |      |

## EvaluationContext:表达式上下文

| 类                        | 说明 |      |
| ------------------------- | ---- | ---- |
| SimpleEvaluationContext   |      |      |
| StandardEvaluationContext |      |      |

## MethodResolver:方法解析器

| 类                        | 说明 |      |
| ------------------------- | ---- | ---- |
| ReflectiveMethodResolver  |      |      |
| DataBindingMethodResolver |      |      |

## MethodExecutor: 方法执行器

| 类                       | 说明 |      |
| ------------------------ | ---- | ---- |
| ReflectiveMethodExecutor |      |      |

## ConstructorResolver:构造方法解析器

| 类                            | 说明 |      |
| ----------------------------- | ---- | ---- |
| ReflectiveConstructorResolver |      |      |

## TypeComparator: 类型比较器

| 类                     | 说明 |      |
| ---------------------- | ---- | ---- |
| StandardTypeComparator |      |      |

## TypeConverter:类型转换器

| 类                    | 说明 |      |
| --------------------- | ---- | ---- |
| StandardTypeConverter |      |      |