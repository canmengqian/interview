# Docker安装

```shell
docker search  grafana
docker pull grafana/grafana
mkdir /data/grafana
mkdir /data/grafana-data/etc/
chmod 777 -R /data/grafana/
chmod 777 -R /data/grafana-data/etc/
docker run -d --name grafana -p 3000:3000 --restart always -v /data/grafana:/var/lib/grafana  grafana/grafana
docker cp grafana:/etc/grafana/grafana.ini /data/grafana-data/etc/
## 重新配置grafana.ini文件
## kill重启
docker kill grafana
docker rm grafana
docker run --user root  -d --name grafana -p 3000:3000  --restart always  -v /data/grafana-data/etc:/etc/grafana/ -v /data/grafana:/var/lib/grafana  grafana/grafana

##进入容器
docker ps # 
sudo docker exec -it 293947168c6f /bin/bash
## 命令地址 /usr/share/grafana/bin
grafana-cli plugins install redis-datasource
docker restart 容器ID


```

# 参考文档

- [docker安装](https://www.cnblogs.com/woshimrf/p/docker-grafana.html)