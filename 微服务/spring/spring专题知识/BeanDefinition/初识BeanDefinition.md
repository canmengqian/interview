[TOC]

# BeanDefinition

```
包含初始化方法,工厂方法,销毁方法的名称
包含注入范围[单例，多例],是否懒加载
获取构造器参数/属性参数
```

# AbstractBeanDefinition

```
定义注入方式[By Name , By Type ,By Construct, By AutoDetect]
定义依赖检查: 不检查,简单检查,全量检查[检查属性依赖]
增加 强制执行init,destroy方法

```

# 自定义bean:BeanDefinitionCustomizer

# BeanDefinition异常体系

```
BeanDefinitionStoreException
NoSuchBeanDefinitionException
```

# 子类及作用

```java
GenericBeanDefinition
RootBeanDefinition
ChildBeanDefinition
```

# 问题点

1. 额外类

   - ```java
     	BeanDefinitionHolder
     	AnnotatedElement
         ResolvableType
         ConstructorArgumentValues
         MutablePropertyValues    
         
     ```


# 文档