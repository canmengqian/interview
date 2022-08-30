[TOC]

# Discard old builds

1. 保持构建的天数
2. 保持构建的最大个数
3. 发布包保留天数
4. 发布包最大保留#个构建
5.  项目参数化
6. 高级选项
   1.  静默期
   2. 重试次数
   3. 该项目的上游项目正在构建时阻止该项目构建
   4. 该项目的下游项目正在构建时阻止该项目构建
7. 保留构建的依赖日志

# 源码管理

## Git

1. 仓库地址
2. git用户凭证
3. 需要进行build的分支【可选择多个分支】
4. 源码库浏览器
5. 其他选项
   1. Advanced checkout behaviours
   2. Advanced clone behaviours
   3. Advanced sub-modules behaviours
   4. Build single revision only
   5. Calculate changelog against a specific branch
   6. Check out to a sub-directory
   7. Check out to specific local branch
   8. Clean after checkout
   9. Clean before checkout
   10. Create a tag for every build
   11. Custom SCM name
   12. Custom user name/e-mail address
   13. Don't trigger a build on commit notifications
   14. Force polling using workspace
   15. Git LFS pull after checkout
   16. Merge before build
   17. Polling ignores commits from certain users
   18. Polling ignores commits in certain paths
   19. Polling ignores commits with certain messages
   20. Prune stale remote-tracking branches
   21. Prune stale tags
   22. Sparse Checkout paths
   23. Strategy for choosing what to build
   24. Use commit author in changelog

## Subversion 

1. 仓库地址: (Repository URL)
2. svn用户凭证(Credentials)
3. 仓库深度(Repository depth)
4. 检出策略(Check-out Strategy)
   1. Use 'svn update' as much as possible
   2. Always check out a fresh copy
   3. Do not touch working copy, it is updated by other script.
   4. Emulate clean checkout by first deleting unversioned/ignored files, then 'svn update'
   5. Use 'svn update' as much as possible, with 'svn revert' before update
5. 源码浏览器

# 构建触发器

1. 其他项目构建完成后再构建 Build after other projects are built
2. 周期性构建 Build periodically
3. Poll SCM 轮询

# 构建环境

1. build开始之前删除工作空间
2. 使用加密文本或文件
3. 如果卡住了则丢弃该构建
4. 对于输出增加时间戳
5. 清理未使用的svn模块
6. Ant使用处理

# 构建

1. 执行windows批处理 Execute Windows batch command
2. 执行shell Execute shell
3. 调用Ant Invoke Ant
4. 调用gradle脚本 Invoke Gradle script
5. 执行maven  Invoke top-level Maven targets
6. 运行超时参数 Run with timeout
7. 设置build状态到github的提交内容中 Set build status to "pending" on GitHub commit

# 构建后操作

1. 聚合下游测试结果 Aggregate downstream test results
2. Archive the artifacts
3. Build另一个项目 Build other projects
4. 发布单元测试结果报告 Publish JUnit test result report
5. 发布javadoc Publish Javadoc
6. Record fingerprints of files to track usage
7. Git Publisher
8. 邮件通知 E-mail Notification
9. 可编辑的邮件通知 Editable Email Notification
10. Reverts commits that breaks the build
11. 设置git提交状态 Set GitHub commit status (universal)
12. build完成时删除工作空间 Delete workspace when build is done