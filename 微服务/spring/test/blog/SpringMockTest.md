SpringMock 使用流程

```txt
1.注解驱动Mock环境(自动配置流程)
2.构造Mock Mvc对象
3.构造Mock Request对象
3.1 设置HttpRequest相关参数(请求参数,请求头/请求体,Cookie,Session,Servlet上下文,文件)
3.2 构造Servlet过滤器
4.返回Mvc结果集并通过结果处理器对结果和预期结果进行比较
```

SpringMock Mvc测试范围

```txt
1. 测试Mvc请求
2. 测试REST请求
3. 测试响应式(webflux)请求
4. 测试webservice
```

Spring Mock涉及的包

```tex
org.springframework.test.web
org.springframework.mock.web
org.springframework.boot.test.autoconfigure.web.servlet
```

