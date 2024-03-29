# 《深入理解Nginx》

## 修改Linux配置

```shell
fs.file-max = 999999  
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.ip_local_port_range = 1024    61000
net.ipv4.tcp_rmem = 4096 32768 262142
net.ipv4.tcp_wmem = 4096 32768 262142
net.core.netdev_max_backlog = 8096
net.core.rmem_default = 262144
net.core.wmem_default = 262144
net.core.rmem_max = 2097152
net.core.wmem_max = 2097152
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn.backlog=1024
```

## Nginx的命令行控制

```shell
/usr/local/nginx/sbin/nginx -c /tmp/nginx.conf  # 另行指定配置文件的启动方式
```

## Niginx配置项

### 基本配置项

```shell
daemon on|off;#Nginx毫无疑问是一个需要以守护进程方式运行的服务，因此，默认都是以这种方式运行的。
master_process on|off;
#如果设置了debug_points为stop，那么Nginx的代码执行到这些调试点时就会发出SIGSTOP信号以用于调试。如果debug_points设置为abort，则会产生一个coredump文件，可以使用gdb来查看Nginx当时的各种信息。
debug_points[stop|abort] 
# 当进程发生错误或收到信号而终止时，系统会将进程执行时的内存内容（核心映像）写入一个文件（core文件），以作为调试之用，这就是所谓的核心转储（core dumps）。当Nginx进程出现一些非法操作（如内存越界）导致进程直接被操作系统强制结束时，会生成核心转储core文件，可以从core文件获取当时的堆栈、寄存器等信息，
worker_rlimit_core size;
#worker进程的工作目录。这个配置项的唯一用途就是设置coredump文件所放置的目录，协助定位问题。因此，需确保worker进程有权限向working_directory指定的目录中写入文件。
working_directory path;
# 设置一个worker进程可以打开的最大文件句柄数。
worker_rlimit_nofile limit;
# 设置每个用户发往Nginx的信号队列的大小。也就是说，当某个用户的信号队列满了，这个用户再发送的信号量会被丢掉。
worker_rlimit_sigpending limit;
#那么，有多少CPU内核就应该配置多少个进程；
worker_processes number;
#
worker_cpu_affinity cpumask[cpumask...]
#每次内核的事件调用（如epoll、select、poll、kqueue等）返回时，都会执行一次gettimeofday，实现用内核的时钟来更新Nginx中的缓存时钟。在早期的Linux内核中，gettimeofday的执行代价不小，因为中间有一次内核态到用户态的内存复制。
 timer_resolution t;
#nice值是进程的静态优先级，它的取值范围是–20~+19，–20是最高优先级，+19是最低优先级。因此，如果用户希望Nginx占有更多的系统资源，那么可以把nice值配置得更小一些，但不建议比内核进程的nice值（通常为–5）还要小。
worker_priority 0;

```

### 事件类配置项

```shell
#accept_mutex是Nginx的负载均衡锁，accept_mutex这把锁可以让多个worker进程轮流地、序列化地与新的客户端建立TCP连接。
accept_mutex[on|off] 
lock_file path/file;
#在使用accept锁后，同一时间只有一个worker进程能够取到accept锁。这个accept锁不是阻塞锁，如果取不到会立刻返回。如果有一个worker进程试图取accept锁而没有取到，它至少要等accept_mutex_delay定义的时间间隔后才能再次试图取锁。
 accept_mutex_delay 500ms;
 #当事件模型通知有新连接时，尽可能地对本次调度中客户端发起的所有TCP请求都建立连接。
 multi_accept[on|off];
 #可供选择的事件驱动模型有poll、select、epoll三种。epoll当然是性能最高的一种
 use[kqueue|rtsig|epoll|/dev/poll|select|poll|eventport];
 
 worker_connections number;
```

### Http块配置

```shell

```

### Server块

```shell
#backlog=num：表示TCP中backlog队列的大小
#·rcvbuf=size：设置监听句柄的SO_RCVBUF参数。
#·sndbuf=size：设置监听句柄的SO_SNDBUF参数。
#deferred：在设置该参数后，若用户发起建立连接请求，并且完成了TCP的三次握手，内核也不会为了这次的连接调度worker进程来处理，只有用户真的发送请求数据时（内核已经在网卡中收到请求数据包），内核才会唤醒worker进程处理这个连接
#
listen address:port[default(deprecated in 0.8.21)|default_server|[backlog=num|rcvbuf=size|sndbuf=size|accept_filter=filter|deferred|bind|ipv6only=[on|off]|ssl]];

#虚拟主机功能。
server_name name[...];
# 为了提高快速寻找到相应server name的能力，Nginx使用散列表来存储server name。server_names_hash_bucket_size设置了每个散列桶占用的内存大小。
server_names_hash_bucket_size size;
#
server_names_hash_max_size 512;
#在使用on打开时，表示在重定向请求时会使用server_name里配置的第一个主机名代替原先请求中的Host头部，而使用off关闭时，表示在重定向请求时使用请求本身的Host头部。
server_name_in_redirect on|off;
#以root方式设置资源路径
# 配置块： http、server、location、if
root path;
#
#http、server、location
index file...;
# 根据HTTP返回码重定向页面 配置块： http、server、location、if
error_page code[code...][=|=answer-code]uri|@named_location
#当值为非off时，用户请求中的HTTP包体一律存储到磁盘文件中，即使只有0字节也会存储为文件。当请求结束时，如果配置为on，则这个文件不会被删除（该配置一般用于调试、定位问题），但如果配置为clean，则会删除该文件
#http、server、location
client_body_in_file_only on|clean|off;
#HTTP包体尽量写入到一个内存buffer中,用户请求中的HTTP包体一律存储到内存buffer中。当然，如果HTTP包体的大小超过了下面client_body_buffer_size设置的值，包体还是会写入到磁盘文件中。
#http、server、location
client_body_in_single_buffer off;
#正常情况下Nginx接收用户请求中HTTP header部分（包括HTTP行和HTTP头部）时分配的内存buffer大小。有时，请求中的HTTP header部分可能会超过这个大小，这时large_client_header_buffers定义的buffer将会生效
# http、server
client_header_buffer_size 1k
#如果HTTP请求行（如GET/index HTTP/1.1）的大小超过上面的单个buffer，则返回"Request URI too large"(414)。
large_client_header_buffers 48k;
#HTTP包体会先接收到指定的这块缓存中，之后才决定是否写入磁盘。 
# http、server、location
client_body_buffer_size 8k/16k;
#Nginx对于每个建立成功的TCP连接会预先分配一个内存池，上面的size配置项将指定这个内存池的初始大小
connection_pool_size size;
#将会为每个请求都分配一个内存池，size配置项将指定这个内存池的初始大小，HTTP请求结束时会销毁request_pool_size指定的HTTP请求内存池，但它们的创建、销毁时间并不一致，因为一个TCP连接可能被复用于多个HTTP请求
request_pool_size size;
#读取HTTP头部的超时时间,如果在一个时间间隔（超时时间）内没有读取到客户端发来的字节，则认为超时，并向客户端返回408("Request timed out")响应。
#http、server、location
client_header_timeout 60;
#读取HTTP包体的超时时间，http、server、location
client_body_timeout 60;
#发送响应的超时时间,Nginx服务器向客户端发送了数据包，但客户端一直没有去接收这个数据包。如果某个连接超过send_timeout定义的超时时间，那么Nginx将会关闭这个连接。 http、server、location
send_timeout time;
# http、server、location.不是使用正常情形下的四次握手关闭TCP连接，而是直接向用户发送RST重置包，不再等待用户的应答，直接释放Nginx服务器上关于这个套接字使用的所有缓存（如TCP滑动窗口）。相比正常的关闭方式，它使得服务器避免产生许多处于FIN_WAIT_1、FIN_WAIT_2、TIME_WAIT状态的TCP连接。
reset_timeout_connection on|off;
# http、server、location。控制Nginx关闭用户连接的方式。always表示关闭用户连接前必须无条件地处理连接上所有用户发送的数据。off表示关闭连接时完全不管连接上是否已经有准备就绪的来自用户的数据。on是中间值，一般情况下在关闭连接前都会处理连接上的用户发送的数据
lingering_close off|on|always;
# http、server、location。这个配置项对于上传大文件很有用。当用户请求的Content-Length大于max_client_body_size配置时，Nginx服务会立刻向用户发送413（Request entity too large）响应。但是，很多客户端可能不管413返回值，仍然持续不断地上传HTTP body，这时，经过了lingering_time设置的时间后，Nginx将不管用户是否仍在上传，都会把连接关闭掉。
lingering_time time;
#http、server、location。lingering_close生效后，在关闭连接前，会检测是否有用户发送的数据到达服务器，如果超过lingering_timeout时间后还没有数据可读，就直接关闭连接；否则，必须在读取完连接缓冲区上的数据并丢弃掉后才会关闭连接。
lingering_timeout time;
# http、server、location, 对某些浏览器禁用keepalive功能
 keepalive_disable[msie6|safari|none]...
# http、server、location，一个keepalive连接在闲置超过一定时间后（默认的是75秒），服务器和浏览器都会去关闭这个连接。当然，keepalive_timeout配置项是用来约束Nginx服务器的，
 keepalive_timeout time（默认单位：秒）;
#http、server、location ,一个keepalive长连接上允许承载的请求最大数
keepalive_requests 100;
#http、server、location
tcp_nodelay on|off;
#http、server、location
tcp_nopush on|off;
#http、server、location
type{...};
#默认MIME type
default_type MIME-type;
#快速寻找到相应MIME type，Nginx使用散列表来存储MIME type与文件扩展名。types_hash_bucket_size设置了每个散列桶占用的内存大小。
types_hash_bucket_size size;
# http、server、location.ypes_hash_max_size影响散列表的冲突率。types_hash_max_size越大，就会消耗更多的内存，但散列key的冲突率会降低，检索速度就更快。types_hash_max_size越小，消耗的内存就越小，但散列key的冲突率可能上升
types_hash_max_size size;
```

### 客户端和文件的配置

```shell
# location 按HTTP方法名限制用户请求,方法名可取值包括：GET、HEAD、POST、PUT、DELETE、MKCOL、COPY、MOVE、OPTIONS、PROPFIND、PROPPATCH、LOCK、UNLOCK或者PATCH。
limit_except method...{...}
#http、server、location.浏览器在发送含有较大HTTP包体的请求时，其头部会有一个Content-Length字段，client_max_body_size是用来限制Content-Length所示值的大小的。因此，这个限制包体的配置.Nginx在收完包头后，发现Content-Length超过client_max_body_size定义的值，就直接发送413("Request Entity Too Large")响应给客户端。
client_max_body_size size;
#对客户端请求限制每秒传输的字节数，
limit_rate speed;
# http、server、location、if。Nginx向客户端发送的响应长度超过limit_rate_after后才开始限速
limit_rate_after time;
# http、server、location,启用Linux上的sendfile系统调用来发送文件，它减少了内核态与用户态之间的两次内存复制，这样就会从磁盘中读取文件后直接在内核态发送到网卡设备，提高了发送文件的效率
sendfile on|off;
#http、server、location,AIO系统调用，与sendfile功能是互斥的。
aio on|off;
#http、server、location,在FreeBSD和Linux系统上使用O_DIRECT选项去读取文件，缓冲区大小为size，通常对大文件的读取速度有优化作用。注意，它与sendfile功能是互斥的
directio size|off;
#http、server、location .文件缓存会在内存中存储以下3种信息：·文件句柄、文件大小和上次修改时间。2·已经打开过的目录结构。3·没有找到的或者没有权限操作的文件信息。

#·max：表示在内存中存储元素的最大个数。当达到最大限制数量后，将采用LRU（Least Recently Used）算法从缓存中淘汰最近最少使用的元素。
#·inactive：表示在inactive指定的时间段内没有被访问过的元素将会被淘汰。默认时间为60秒。
#off：关闭缓存功能。
open_file_cache max=N[inactive=time]|off;
# http、server.如果将其设置为off，那么当出现不合法的HTTP头部时，Nginx会拒绝服务，并直接向用户发送400（Bad Request）错误。如果将其设置为on，则会忽略此HTTP头部。
ignore_invalid_headers on;
#HTTP头部是否允许下划线
underscores_in_headers on|off;
# http、server、location
if_modified_since[off|exact|before];
#文件未找到时是否记录到error日志
 log_not_found on;
# http、server、location,设置DNS名字解析服务器的地址
 resolver address...;
# DNS解析的超时时间
resolver_timeout time;

```

### 负载均衡和反向代理

```shell
#upstream块定义了一个上游服务器的集群，便于反向代理中的proxy_pass使用
#weight=number：设置向这台上游服务器转发的权重，默认为1。
#·max_fails=number：该选项与fail_timeout配合使用，指在fail_timeout时间段内，如果向#当前的上游服务器转发失败次数超过number，则认为在当前的fail_timeout时间段内这台上游服务#器不可用。max_fails默认为1，如果设置为0，则表示不检查失败次数。

#·fail_timeout=time：fail_timeout表示该时间段内转发失败多少次后就认为上游服务器暂时不#可用，用于优化反向代理功能。它与向上游服务器建立连接的超时时间、读取上游服务器的响应超时时#间等完全无关。fail_timeout默认为10秒。

#·down：表示所在的上游服务器永久下线，只在使用ip_hash配置项时才有用。

#·backup：在使用ip_hash配置项时它是无效的。它表示所在的上游服务器只是备份服务器，只有在##所有的非备份上游服务器都失效后，才会向所在的上游服务器转发请求。
upstream backend {
	ip_hash;
  server backend1.example.com;
  server backend2.example.com;
  server backend3.example.com;
  server   127.0.0.1:8080          max_fails=3  fail_timeout=30s;
}
server {
  location / {
    proxy_pass  http://backend;
}
}
# http、server、location
proxy_method method;
#
```

## 问题点:

- TCP 滑动窗口是什么,backLog是什么
- TCP连接重置
- keepalive中TCP_NODELAY是什么
- tcp_nopush 是什么