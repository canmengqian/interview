[TOC]

##### OpenOption:配置如何打开或创建文件的对象

```
配置如何打开或创建文件的对象。
这种类型的对象在打开或创建文件时由newOutputStream 、 newByteChannel 、 FileChannel.open和AsynchronousFileChannel.open等方法使用。
StandardOpenOption枚举类型定义了标准选项
```

##### CopyOption : 配置如何复制或移动文件的对象

```
配置如何复制或移动文件的对象。
这种类型的对象可以与Files.copy(Path,Path,CopyOption...) Files.copy(InputStream,Path,CopyOption...)和Files.move(Path,Path,CopyOption...)方法来配置文件的复制或移动方式。
StandardCopyOption枚举类型定义标准选项。
```

##### DirectoryStream:迭代目录中条目的对象

```
迭代目录中条目的对象。 目录流允许方便地使用 for-each 结构来遍历目录。
虽然DirectoryStream扩展了Iterable ，但它不是通用的Iterable因为它只支持单个Iterator ； 调用iterator方法来获取第二个或后续迭代器会抛出IllegalStateException 。
目录流的Iterator一个重要属性是它的hasNext方法保证至少由一个元素预读。 如果hasNext方法返回true ，并随后调用next方法，则保证next方法不会因 I/O 错误或因为流已closed而抛出异常。 Iterator不支持remove操作。
DirectoryStream在创建时打开，并通过调用close方法close 。 关闭目录流会释放与该流相关联的任何资源。 未能关闭流可能会导致资源泄漏。 try-with-resources 语句提供了一个有用的构造来确保流关闭：
     Path dir = ...
     try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir)) {
         for (Path entry: stream) {
             ...
         }
     }
   
关闭目录流后，使用Iterator进一步访问该目录的行为就像已到达流末尾一样。 由于预读， Iterator可能会在目录流关闭后返回一个或多个元素。 一旦这些缓冲的元素被读取，那么后续调用hasNext方法返回false ，并以后续调用next方法将抛出NoSuchElementException 。
目录流不需要异步关闭。 如果一个线程在从目录读取的目录流的迭代器上被阻塞，而另一个线程调用close方法，那么第二个线程可能会阻塞，直到读取操作完成。
如果在访问目录时遇到 I/O 错误，则会导致Iterator的hasNext或next方法以IOException作为原因抛出DirectoryIteratorException 。 如上所述， hasNext方法保证至少预读一个元素。 这意味着如果hasNext方法返回true ，然后调用next方法，则可以保证next方法不会因DirectoryIteratorException而失败。
迭代器返回的元素没有特定的顺序。 一些文件系统维护到目录本身和目录的父目录的特殊链接。 迭代器不返回表示这些链接的条目。
迭代器是弱一致的。 它是线程安全的，但在迭代时不会冻结目录，因此它可能（也可能不会）反映在创建DirectoryStream后发生的目录更新。
用法示例：假设我们想要一个目录中的源文件列表。 此示例同时使用 for-each 和 try-with-resources 构造。
     List<Path> listSourceFiles(Path dir) throws IOException {
         List<Path> result = new ArrayList<>();
         try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir, "*.{c,h,cpp,hpp,java}")) {
             for (Path entry: stream) {
                 result.add(entry);
             }
         } catch (DirectoryIteratorException ex) {
             // I/O error encounted during the iteration, the cause is an IOException
             throw ex.getCause();
         }
         return result;
     }
```

##### FileVisitor:文件的访问者

```java
文件的访问者。 此接口的实现提供给Files.walkFileTree方法以访问文件树中的每个文件。
用法示例：假设我们要删除一个文件树。 在这种情况下，应在删除目录中的条目后删除每个目录。
       Path start = ...
       Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
           @Override
           public FileVisitResult visitFile(Path file, BasicFileAttributes attrs)
               throws IOException
           {
               Files.delete(file);
               return FileVisitResult.CONTINUE;
           }
           @Override
           public FileVisitResult postVisitDirectory(Path dir, IOException e)
               throws IOException
           {
               if (e == null) {
                   Files.delete(dir);
                   return FileVisitResult.CONTINUE;
               } else {
                   // directory iteration failed
                   throw e;
               }
           }
       });
   
此外，假设我们要将文件树复制到目标位置。 在这种情况下，应遵循符号链接并在复制目录中的条目之前创建目标目录。
       final Path source = ...
       final Path target = ...
  
       Files.walkFileTree(source, EnumSet.of(FileVisitOption.FOLLOW_LINKS), Integer.MAX_VALUE,
           new SimpleFileVisitor<Path>() {
               @Override
               public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs)
                   throws IOException
               {
                   Path targetdir = target.resolve(source.relativize(dir));
                   try {
                       Files.copy(dir, targetdir);
                   } catch (FileAlreadyExistsException e) {
                        if (!Files.isDirectory(targetdir))
                            throw e;
                   }
                   return CONTINUE;
               }
               @Override
               public FileVisitResult visitFile(Path file, BasicFileAttributes attrs)
                   throws IOException
               {
                   Files.copy(file, target.resolve(source.relativize(file)));
                   return CONTINUE;
               }
           });
```

##### Path:可用于在文件系统中定位文件的对象

```java
可用于在文件系统中定位文件的对象。 它通常表示系统相关文件路径。
Path表示一个分层的路径，由一系列由特殊分隔符或定界符分隔的目录和文件名元素组成。 也可能存在标识文件系统层次结构的根组件。 离目录层次结构根最远的名称元素是文件或目录的名称。 其他名称元素是目录名称。 Path可以表示一个根、一个根和一系列名称，或者只是一个或多个名称元素。 如果Path仅由一个空的名称元素组成，则该Path被认为是空路径。 使用空路径访问文件相当于访问文件系统的默认目录。 Path定义了getFileName 、 getParent 、 getRoot和subpath方法来访问路径组件或其名称元素的子序列。
除了访问路径的组件之外， Path还定义了resolve和resolveSibling方法来组合路径。 可用于构造两条路径之间的相对路径的relativize方法。 可以使用startsWith和endsWith方法compared和测试路径。
该接口扩展了Watchable接口，以便通过路径定位的目录可以registered到WatchService并监视目录中的条目。
警告：此接口仅供那些开发自定义文件系统实现的人实现。 在将来的版本中可能会向此接口添加方法。
访问文件
路径可以与Files类一起使用，以对文件、目录和其他类型的文件进行操作。 例如，假设我们希望java.io.BufferedReader从文件“ access.log ”中读取文本。 该文件位于相对于当前工作目录的“ logs ”目录中，采用 UTF-8 编码。
       Path path = FileSystems.getDefault().getPath("logs", "access.log");
       BufferedReader reader = Files.newBufferedReader(path, StandardCharsets.UTF_8);
   

互操作性
与默认provider关联的路径通常可与java.io.File类互操作。 其他提供者创建的路径不太可能与java.io.File表示的抽象路径名互操作。 toPath方法可用于从java.io.File对象表示的抽象路径名中获取Path 。 生成的Path可用于对与java.io.File对象相同的文件进行操作。 此外， toFile方法对于从Path的String表示构造File很有用。
并发
此接口的实现是不可变的，并且可以安全地供多个并发线程使用。
```

##### FileTreeIterator:

```java
An Iterator to iterate over the nodes of a file tree. <pre>{@code try (FileTreeIterator iterator = new FileTreeIterator(start, maxDepth, options)) { while (iterator.hasNext()) { Event ev = iterator.next(); Path path = ev.file(); BasicFileAttributes attrs = ev.attributes(); } } }
```

##### FileTreeWalker

```java
遍历文件树，生成与树中文件对应的事件序列。
 
     Path top = ...
     Set<FileVisitOption> options = ...
     int maxDepth = ...

     try (FileTreeWalker walker = new FileTreeWalker(options, maxDepth)) {
         FileTreeWalker.Event ev = walker.walk(top);
         do {
             process(ev);
             ev = walker.next();
         } while (ev != null);
     }
```

##### TempFileHelper : 支持创建具有初始属性的临时文件和目录

```
Helper 类支持创建具有初始属性的临时文件和目录。
```

##### FileSystems : 文件系统的工厂方法

```java
文件系统的工厂方法。 该类定义了getDefault方法来获取默认文件系统和工厂方法来构造其他类型的文件系统。
此类定义的任何方法的第一次调用都会导致加载默认provider 。 由 URI 方案“文件”标识的默认提供程序创建FileSystem ，该文件系统提供对 Java 虚拟机可访问的文件系统的访问。 如果加载或初始化默认提供程序的过程失败，则会引发未指定的错误。
通过调用newFileSystem定义的任何newFileSystem方法，对installedProviders方法的第一次调用定位并加载所有已安装的文件系统提供程序。 已安装的提供程序使用由ServiceLoader类定义的服务提供程序加载工具加载。 已安装的提供程序使用系统类加载器加载。 如果找不到系统类加载器，则使用扩展类加载器； 如果没有扩展类加载器，则使用引导类加载器。 通常通过将提供程序放置在应用程序类路径或扩展目录中的 JAR 文件中来安装提供程序，该 JAR 文件在资源目录META-INF/services包含名为java.nio.file.spi.FileSystemProvider的提供程序配置文件，并且该文件列出了FileSystemProvider具有零参数构造函数的具体子类的一个或多个完全限定名称。 已安装的提供程序所在的顺序是特定于实现的。 如果提供者被实例化并且其getScheme返回先前实例化的提供者的相同 URI 方案，则最近实例化的副本将被丢弃。 URI 方案的比较不考虑大小写。 在构建期间，提供者可以安全地访问与默认提供者关联的文件，但需要注意避免其他已安装提供者的循环加载。 如果检测到已安装提供程序的循环加载，则会引发未指定的错误。
此类还定义了允许在定位提供者时指定ClassLoader工厂方法。 与已安装的提供程序一样，提供程序类通过将提供程序配置文件放置在资源目录META-INF/services来标识。
如果一个线程启动加载已安装的文件系统提供程序，而另一个线程调用一个也尝试加载提供程序的方法，则该方法将阻塞，直到加载完成。
```

##### FileSystem:提供文件系统的接口，是对象访问文件系统中的文件和其他对象的工厂。

```java
提供文件系统的接口，是对象访问文件系统中的文件和其他对象的工厂。
通过调用FileSystems.getDefault方法获得的默认文件系统提供对 Java 虚拟机可访问的文件系统的访问。 FileSystems类定义了创建文件系统的方法，这些文件系统提供对其他类型（自定义）文件系统的访问。
文件系统是多种类型对象的工厂：
getPath方法转换系统相关路径 string ，返回可用于定位和访问文件的Path对象。
getPathMatcher方法用于创建对路径执行匹配操作的PathMatcher 。
getFileStores方法在底层file-stores返回一个迭代器。
getUserPrincipalLookupService方法返回UserPrincipalLookupService以按名称查找用户或组。
newWatchService方法创建一个WatchService ，可用于监视对象的更改和事件。
文件系统差别很大。 在某些情况下，文件系统是具有一个顶级根目录的单个文件层次结构。 在其他情况下，它可能有几个不同的文件层次结构，每个层次结构都有自己的顶级根目录。 getRootDirectories方法可用于遍历文件系统中的根目录。 文件系统通常由一个或多个为file-stores提供存储的底层file-stores组成。 这些文件存储还可以在它们支持的功能以及它们与文件关联的文件属性或元数据方面有所不同。
文件系统在创建时打开，可以通过调用其close方法close 。 一旦关闭，任何进一步尝试访问文件系统中的对象都会导致抛出ClosedFileSystemException 。 无法关闭由默认provider创建的文件系统。
FileSystem可以提供对文件系统的只读或读写访问。 文件系统是否提供只读访问是在创建FileSystem建立的，可以通过调用其isReadOnly方法进行测试。 尝试通过与只读文件系统关联的对象写入文件存储会引发ReadOnlyFileSystemException 。
多个并发线程可以安全地使用文件系统。 可以随时调用close方法来关闭文件系统，但文件系统是否可异步关闭是特定于提供者的，因此未指定。 换句话说，如果一个线程正在访问文件系统中的一个对象，而另一个线程调用了close方法，那么它可能需要阻塞直到第一个操作完成。 关闭文件系统会导致与文件系统关联的所有打开的频道、观看服务和其他closeable对象被关闭
```

##### FileStore:表示存储池、设备、分区、卷、具体文件系统或其他实现特定的文件存储方式

```java
文件存储。 FileStore表示存储池、设备、分区、卷、具体文件系统或其他实现特定的文件存储方式。 通过调用getFileStore方法获取文件所在的FileStore ，也可以通过调用getFileStores方法枚举所有文件存储。
除了此类定义的方法之外，文件存储还可以支持一个或多个FileStoreAttributeView类，这些类提供一组文件存储属性的只读或可更新视图。
```

##### Files:仅包含对文件、目录或其他类型文件进行操作的静态方法

```java
此类仅包含对文件、目录或其他类型文件进行操作的静态方法。
在大多数情况下，此处定义的方法将委托给关联的文件系统提供程序来执行文件操作
```

##### Paths:包含通过转换路径字符串或URI返回Path的静态方法

```java
此类仅包含通过转换路径字符串或URI返回Path的静态方法
```

##### WatchService

```java
监视服务，监视已注册的对象的变化和事件。 例如，文件管理器可以使用监视服务来监视目录的更改，以便在创建或删除文件时更新文件列表的显示。
Watchable对象通过调用其register方法向监视服务register ，返回一个WatchKey来表示注册。 当检测到一个对象的事件时，密钥会被发出信号，如果当前没有发出信号，它会排队等待观察服务，以便调用poll或take方法来检索密钥和处理事件的消费者可以检索它。 一旦事件被处理，消费者调用键的reset方法来重置键，这允许键被发送信号并与进一步的事件重新排队。
通过调用密钥的cancel方法取消对监视服务的注册。 在取消时排队的键将保留在队列中，直到它被检索为止。 根据对象，键可能会自动取消。 例如，假设一个目录被监视并且监视服务检测到它已被删除或其文件系统不再可访问。 当一个键以这种方式被取消时，它会被发送信号并排队，如果当前没有被发送信号。 为了确保通知消费者， reset方法的返回值指示密钥是否有效。
多个并发消费者可以安全地使用监视服务。 为确保在任何时候只有一个消费者处理特定对象的事件，则应注意确保仅在处理其事件后才调用键的reset方法。 可以随时调用close方法来关闭服务，从而导致任何等待检索密钥的线程抛出ClosedWatchServiceException 。
文件系统报告事件的速度可能比检索或处理它们的速度快，并且实现可能对其可能累积的事件数量施加未指定的限制。 如果实现有意丢弃事件，则它会安排键的pollEvents方法返回事件类型为OVERFLOW的元素。 消费者可以使用此事件作为重新检查对象状态的触发器。
当报告事件指示监视目录中的文件已被修改时，不能保证修改该文件的程序（或多个程序）已完成。 应注意与可能正在更新文件的其他程序协调访问。 FileChannel类定义了锁定文件区域以防止其他程序访问的方法。
平台依赖
从文件系统观察事件的实现旨在直接映射到可用的本地文件事件通知工具，或者在本地工具不可用时使用原始机制，例如轮询。 因此，关于如何检测事件、它们的及时性以及它们的排序是否保留的许多细节都是高度特定于实现的。 例如，当监视目录中的文件被修改时，在某些实现中可能会导致单个ENTRY_MODIFY事件，但在其他实现中可能会导致多个事件。 定期轮询文件系统以检测更改的原始实现可能无法检测到短期文件（意味着文件在创建后很快被删除）。
如果监视的文件不在本地存储设备上，那么是否可以检测到文件的更改是实现特定的。 特别是，不需要检测在远程系统上执行的文件更改。
```

##### WatchKey

```java
一个令牌，表示向WatchService注册可watchable对象。
当一个可观察对象注册到一个观察服务时，就会创建一个观察键。 密钥一直valid直到：
通过调用其cancel方法显式cancel它，或
隐式取消，因为对象不再可访问，或
通过closing手表服务。
手表键有一个状态。 最初创建时，密钥被称为就绪。 当检测到一个事件时，该键将被发送信号并排队，以便可以通过调用 watch 服务的poll或take方法来检索它。 一旦发出信号，密钥将保持此状态，直到调用其reset方法将密钥返回到就绪状态。 密钥处于信号状态时检测到的事件将排队，但不会导致密钥重新排队以从监视服务中检索。 通过调用键的pollEvents方法检索事件。 此方法检索并删除为对象累积的所有事件。 最初创建时，监视键没有未决事件。 通常，当密钥处于信号状态时会检索事件，从而导致以下习语：
       for (;;) {
           // retrieve key
           WatchKey key = watcher.take();
  
           // process events
           for (WatchEvent<?> event: key.pollEvents()) {
               :
           }
  
           // reset the key
           boolean valid = key.reset();
           if (!valid) {
               // object no longer registered
           }
       }
   
多个并发线程可以安全地使用监视键。 如果有多个线程从监视服务检索信号键，则应注意确保仅在处理对象的事件后才调用reset方法。 这确保了一个线程随时都在处理对象的事件
```



