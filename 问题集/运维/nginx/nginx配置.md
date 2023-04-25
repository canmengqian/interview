# Nginx配置

```sh
#user  nobody;
daemon on;
pid ./xxx.pid
user nobody
worker_processes  1;                                    # 只启动一个工作进程
error_log  logs/error.log debug;                        # 错误日志输
pcre_jit on;                                            # 启用pcre_jit正则加速编译技术
thread_pool default threads=32 max_queue=65536;         # 线程池的线程数为32，等待队列中的最大任务数为65536
timer_resolution 100ms;                                 # 定时器周期为100毫秒
worker_priority -5;                                     # 工作进程系统优先级为-5
worker_processes auto;                                  # 工作进程数由Nginx自动调整
worker_cpu_affinity auto;                               # 工作进程的CPU绑定由Nginx自动调整
worker_rlimit_nofile 65535;                             # 所有工作进程的最大连接数是65535
worker_shutdown_timeout 10s;                            # 工作进程关闭等待时间是10秒
lock_file logs/nginx.lock;                              # 互斥锁文件的位置是logs/nginx.lock
working_directory logs                                  # 工作进程工作目录是logs
debug_points stop;                                      # 调试点模式为stop
worker_rlimit_core 800m;                                # 崩溃文件大小为800MB
events {
    worker_connections  1024;               # 每个工作进程的最大连接为1024
    accept_mutex_delay 300ms; #Nginx 工作进程在互斥锁模式下需要不断地争抢互斥锁，没有互斥镇的工作进程如果争抢不到互斥锁，会在等待时间结束后执行下一轮争抢。通过该指令可以将抢锁等待时间设置为一个较短的时间，以提高进程争抢互斥锁的频率
    multi_accept on;  #默认情况下，每个工作进程一次只接收一个新连接。如果开启指令，则每个工作进程将接收所有的新连接
    worker_aio_requests 128; #用于设置当在 epol1 事件模型下使用AIO 时，单个工作进程未完成异步 /0 操作的最大数
  
}
http {
    include       mime.types;               # 引入MIME类型映射表文件
    default_type  application/octet-stream;   # 全局默认映射类型为application/octet-stream
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent” "$http_x_forwarded_for"';
    #access_log  logs/access.log  main;
    sendfile        on;                     # 启用零复制机制
    keepalive_timeout  65;                  # 保持连接超时时间为65s
    server {
        listen       80;                    # 监听80端口的网络连接请求
        server_name  localhost;             # 虚拟主机名为localhost
        #charset koi8-r;
        #access_log  logs/host.access.log  main;
        location / {
            root   html; 
            index  index.html index.htm;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}
```

