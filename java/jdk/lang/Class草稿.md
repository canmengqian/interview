# Class类备注

## 成员权限检查

```java
checkMemberAccess(int which, Class<?> caller, boolean checkProxyInterfaces)
checkPackageAccess(final ClassLoader ccl, boolean checkProxyInterfaces)
Proxy.isProxyClass(this)    
    
```

## 属性copy

```java
copyConstructors(Constructor<U>[] arg)
额外知识
ReflectionFactory fact = getReflectionFactory();
```

## 杂类

-  forName()方法
- 

## 扩展类

1.  AccessController
2.  SecurityManager
3.  CoreReflectionFactory
4.  ClassRepository
5.  ProtectionDomain



# Class类问题点

1.  clazz.isAssignableFrom()方法作用
2.  getDeclaredFields,getDeclaredMethods，getDeclaredConstructors,getDeclaredClasses
3.  isInstance()