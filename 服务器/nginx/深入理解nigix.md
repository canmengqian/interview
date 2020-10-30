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
```

