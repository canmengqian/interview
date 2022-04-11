# 指令集

1. worker_processes
2. events
   1.  worker_connections  每个工作进程的最大连接为1024
3.  http 
   1.  include       
   2.  default_type  
   3. log_format  
   4.  access_log  
   5.  sendfile        
   6.  keepalive_timeout  
   7. server
      1.  listen       
      2. server_name  
      3.  location 
         1.  root   
         2.  index  

| 指令             |      |      |
| ---------------- | ---- | ---- |
| worker_processes |      |      |
| events           |      |      |
|                  |      |      |



# 默认变量

| 变量名                   |      |      |
| ------------------------ | ---- | ---- |
| $remote_addr             |      |      |
| $remote_user             |      |      |
| $time_local              |      |      |
| $request                 |      |      |
| $status $body_bytes_sent |      |      |
| $http_referer            |      |      |
| $http_user_agent         |      |      |
| $http_x_forwarded_for    |      |      |
|                          |      |      |
|                          |      |      |
|                          |      |      |
|                          |      |      |
|                          |      |      |
|                          |      |      |
|                          |      |      |

