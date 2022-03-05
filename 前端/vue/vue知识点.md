[TOC]



## vue-cli使用

[Vue.js 安装](https://www.runoob.com/vue2/vue-install.html)

[IDEA中Vue的安装和使用（最全篇）](https://blog.csdn.net/CCIEJohn_zhou/article/details/89043500)

## VUE生命周期 :imp:(必须记住生命周期图)

### VUE对象

#### [全局配置](https://cn.vuejs.org/v2/api/#全局配置)

#### [全局 API](https://cn.vuejs.org/v2/api/#全局-API)

#### [选项 / 数据](https://cn.vuejs.org/v2/api/#选项-数据)

#### [生命周期钩子](https://cn.vuejs.org/v2/api/#选项-生命周期钩子)

#### 属性/数据/事件/生命周期

#### [内置的组件](https://cn.vuejs.org/v2/api/#内置的组件)

## VUE标签

### 数据绑定

#### v-bind 

- 既可以绑定数据也可以绑定标签属性

#### v-model

#### v-once

```vue
你也能执行一次性地插值，当数据改变时，插值处的内容不会更新
```

#### [v-html](https://cn.vuejs.org/v2/api/#v-html)

```vue
双大括号会将数据解释为普通文本，而非 HTML 代码。为了输出真正的 HTML，你需要使用 v-html
```



#### 模板代码

- {{ message }}

### 逻辑判断

#### v-if

#### v-else

#### v-else-if

#### v-show

#### 模板样式

### 循环

#### v-for

- v-for遍历对象列表 ，迭代对象,迭代整数

```vue
v-for 指令需要以 site in sites 形式的特殊语法
第一个参数为值,提供第二个的参数为键名：第三个参数为索引
<li v-for="(value, key, index) in object">
     {{ index }}. {{ key }} : {{ value }}
</li>
```

### 事件

#### v-on:事件名

#### @事件名 [缩写模式]

## VUE 内置方法

### computed

```

```

### watch

## VUE组件



