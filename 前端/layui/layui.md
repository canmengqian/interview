[TOC]



## 语法

- 组件如何更改属性

- 事件触发几种方式
  - id，class
  - 过滤器

## 表格

- [layui数据表格使用（一：基础篇，数据展示、分页组件、表格内嵌表单和图片）](https://www.cnblogs.com/thirteen-zxh/p/9529938.html)
- [使用LayUI操作数据表格](https://www.cnblogs.com/jingch/p/7620075.html)
- [layui隐藏列](https://blog.csdn.net/u011229848/article/details/81781542)

## 表单

### 表单验证

- [layui input标签 type=number 输入整数/小数](https://blog.csdn.net/only_neo/article/details/88311334)
- [layui怎么刷新当前页面？](https://www.html.cn/framework/layui/18599.html)
- 下拉框初始化赋值
  - [初始化代码中拉框值并](https://www.yunbook.vip/post/b8069d67f64a.html)
- 表单带附件提交

### 弹出窗口

- 父子窗口,窗口定时关闭
  - 父窗口向子窗口属性填值,子窗口向父窗口属性填值,
    - [layui弹窗间的传值（layui弹出层传值）(窗口传值)](https://blog.csdn.net/asdfghjkl110292/article/details/89012727?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control)
    - [详解layui弹窗父子窗口之间传参数的方法](http://www.hechaku.com/arcitle/20189928.html)
  - 父窗口向子窗口批量填值,子窗口向父窗口批量填值,
- [Layui Layer在open弹出层中异步加载数据和form表单radio、checkbox、select不渲染，不可点击的解决办法](https://blog.csdn.net/qq_34873338/article/details/78726167)

### 其他组件

- [layui下拉框获取值与数据回显](https://bebugless.com/blogs/329209/)
- [layui下拉框渲染问题，以及回显问题](https://www.cnblogs.com/coderxiaobai/p/13113494.html)

## 样式

- [layui表单必填项带*样式](https://blog.csdn.net/qq_24562495/article/details/104516722)
- 项目搭建方式
  - 模块引用 ，自带模块都有哪些?
  - 扩展组件
  - 路径引用问题,重要

## 常用方法

| 方法名                                   | 作用                                                         |          |
| ---------------------------------------- | ------------------------------------------------------------ | -------- |
| *layui.config(options)*                  |                                                              |          |
| *layui.define([mods], callback)*         |                                                              | 暂时不用 |
| *layui.use([mods], callback)*            |                                                              |          |
| *layui.data(table, settings)*            |                                                              |          |
| *layui.sessionData(table, settings)*     |                                                              |          |
| layui.each(obj, fn)                      | 对象（Array、Object、DOM 对象等）遍历，可用于取代for语句     |          |
| layui.getStyle(node, name)               | 获得一个原始 DOM 节点的 style 属性值，如：layui.getStyle(document.body, 'font-size') |          |
| layui.img(url, callback, error)          | 图片预加载                                                   |          |
| layui.hint()                             | 向控制台打印一些异常信息，目前只返回了 error 方法：layui.hint().error('出错啦') |          |
| layui.onevent(modName, events, callback) | 增加自定义模块事件。有兴趣的同学可以阅读 layui.js 源码以及 form 模块 |          |
| layui.event(modName, events, params)     | 执行自定义模块事件，搭配 onevent 使用                        |          |
|                                          |                                                              |          |
|                                          |                                                              |          |
|                                          |                                                              |          |

​	

```javascript
form.render(); //更新全部
form.render('select'); //刷新select选择框渲染
```

问题 

- 为什么表单不显示？
  - 当你使用表单时，layui 会对 select、checkbox、radio 等原始元素隐藏，从而进行美化修饰处理。但这需要依赖于 form 组件，所以你必须加载 *form*，并且执行一个实例。[#详见说明](https://www.layui.com/doc/modules/form.html#render)
  - 同理的还有 [element 模块](https://www.layui.com/doc/modules/element.html#render)

- 查询索引
  - layer.getChildFrame(selector, index) - 获取iframe页的DOM
- 遍历each

