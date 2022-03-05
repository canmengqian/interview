[TOC]

# Drools文件规则

- import & package
- LHS & RHS
- Working Memory

## 基本语法

- activation-group ""
- agenda-group ""
- attributes
- auto-focus
- calendars
- date-effective ""
- date-expires ""
- dialect: 指定方言

  - mvel,java
- declare ...end
- enabled
- function
- global
- import
- lock-on-active
- no-loop [true,false]
- ruleflow-group ""
- retract
- rule
- salience
- timer
- package
- when...then...end
- queries
- 模式匹配

  - $p: Person(age>0)

## 元注解

- @role

- @timestamp
- @duration
- @typesafe

## 内置方法

- eval
- insert/insertLogical
- update
- modify
- retract
- delete

# 宏对象

- kcontext
- drools

# Session

