## Scala语法

[TOC]

### Scala语言特性特性

- Scala是一种纯`面向对象`的语言，每个值都是对象。对象的数据类型以及行为由类和特质描述。类抽象机制的扩展有两种途径：一种途径是`子类继承`，另一种途径是灵活的`混入机制`。这两种途径能避免多重继承的种种问题。

- Scala也是一种函数式语言，其函数也能当成值来使用。Scala提供了轻量级的语法用以定义`匿名函数，支持高阶函数，允许嵌套多层函数，并支持柯里化`。Scala的case
  class及其内置的模式匹配相当于函数式编程语言中常用的代数类型。

- 静态类型

    - ```reStructuredText
        Scala具备类型系统，通过编译时检查，保证代码的安全性和一致性。类型系统具体支持以下特性：
        泛型类
        协变和逆变
        标注
        类型参数的上下限约束
        把类别和抽象类型作为对象成员
        复合类型
        引用自己时显式指定类型
        视图
        多态方法
        ```

### 基本语法

#### 变量声明

- 使用关键词 **"var"** 声明变量，使用关键词 **"val"** 声明常量。

    ```scala
    var myVar : String = "Foo"
    var myVar : String = "Too"
    /**
    多个变量的声明：
    */
    val xmax, ymax = 100  // xmax, ymax都声明为100
    ```

#### 方法声明

- 1.方法定义由一个 def 关键字开始，紧接着是可选的参数列表，一个冒号 : 和方法的返回类型，一个等于号 = ，最后是方法的主体。2.参数列表中的参数可以使用逗号分隔。

```scala

def functionName ([参数列表]) : [return type] = {
   function body
   return [expr]
}
```

- 方法没有返回值，可以返回为 **Unit**，这个类似于 Java 的 **void**, 实例如下：

    ```scala
    object Hello{
       def printMe( ) : Unit = {
          println("Hello, Scala!")
       }
    }
    ```

- main方法定义

    ```scala
    def main(args: Array[String]) {
          println( "hello world" )
      }
    ```

```scala
final case class Symbol private (name: String) {
   override def toString: String = "'" + name
}
```

```

```