## SpringMvc常用类

[TOC]



### 容器类

| 类名                                     | 描述 |
| ---------------------------------------- | ---- |
| ConfigurableWebApplicationContext        |      |
| ContextRefreshListener                   |      |
| ConfigurableEnvironment                  |      |
| SourceFilteringListener                  |      |
| RequestContext                           |      |
| WebApplicationContext                    |      |
| XmlWebApplicationContext                 |      |
| AbstractRefreshableWebApplicationContext |      |
| WebApplicationObjectSupport              |      |
| FrameworkServlet                         |      |

### 数据模型类

| 类名         | 描述 |
| ------------ | ---- |
| ModelAndView |      |
| Model        |      |
| View         |      |
| ModelMap     |      |
|              |      |



### 组件类(映射处理) -- HandlerMapping

| 类名                           | 描述                                 |
| ------------------------------ | ------------------------------------ |
| HandlerMapping                 | 根据request查找Handler和Interceptors |
| HandlerAdapter                 |                                      |
| SimpleControllerHandlerAdapter |                                      |
| HandlerExceptionResolver       |                                      |
|                                |                                      |

### 组件类(视图解析器) -- ViewResolver

| 类名                           | 描述                                                  |
| :----------------------------- | ----------------------------------------------------- |
| ViewResolver                   |                                                       |
| View                           |                                                       |
| ResourceBundleViewResolver     |                                                       |
| UrlBasedViewResolver           |                                                       |
| RequestToViewNameTranslator    |                                                       |
| ContentNegotiatingViewResolver | 在别的解析器解析的结果上增加了对MediaType和后缀的支持 |
| RedirectView                   |                                                       |

<img src="../image\springmvc\view.png"  />

### 组件类(异常解析器)

| 类名                     | 描述 |
| :----------------------- | ---- |
| HandlerExceptionResolver |      |
|                          |      |

### 组件类(地域处理) -- LocaleResolver

| 类名                    | 描述 |
| :---------------------- | ---- |
| LocaleResolver          |      |
| LocaleChangeInterceptor |      |
| LocaleContextHolder     |      |

### 组件类(主题) -- ThemeResolver

| 类名                   | 描述 |
| :--------------------- | ---- |
| ThemeResolver          |      |
| FixedThemeResolver     |      |
| ThemeSource            |      |
| Theme                  |      |
| ThemeChangeInterceptor |      |

### 组件类(文件上传) -- MultipartResolver

| 类名                             | 描述 |
| :------------------------------- | ---- |
| MultipartResolver                |      |
| MultipartHttpServletRequest      |      |
| StandardServletMultipartResolver |      |
| CommonsMultipartResolver         |      |

### 参数传递 FlashMapManager

| 类名                   | 描述 |
| :--------------------- | ---- |
| FlashMapManager        |      |
| SessionFlashMapManager |      |
| FlashMap               |      |
|                        |      |

### 异步请求

| 类名              | 描述 |
| :---------------- | ---- |
| AsyncContext      |      |
| AsyncWebRequest   |      |
| WebAsyncManager   |      |
| AsyncEvent        |      |
| WebAsyncTask      |      |
| DeferredResult    |      |
| ListenableFuture  |      |
| AsyncRestTemplate |      |
| AsyncTaskExecutor |      |

### 数据转换,格式化,校验

| 类名                 | 描述 |
| :------------------- | ---- |
| HttpMessageConverter |      |
| Formatter            |      |
| ConversionService    |      |
| Errors               |      |

### 工具类

| 类名                | 描述 |
| :------------------ | ---- |
| RequestContextUtils |      |
| BeanFactoryUtils    |      |
| PatternMatchUtils   |      |
| BeanUtils           |      |
| StringUtils         |      |
| AnnotationUtils     |      |

### 其他

| 类名                   | 描述 |
| :--------------------- | ---- |
| MultiValueMap          |      |
| SessionFlashMapManager |      |
| FlashMap               |      |
|                        |      |