# 开始

- [GETTING STARTED](https://prometheus.io/docs/prometheus/latest/getting_started/#getting-started)

-  URL
  - http://localhost:9090/graph 
  -  [localhost:9090/metrics](http://localhost:9090/metrics)

## 查询用例

```shell
# 
prometheus_target_interval_length_seconds{quantile="0.99"}
#
count(prometheus_target_interval_length_seconds)
#
rate(prometheus_tsdb_head_chunks_created_total[1m])
```

# 参数配置

- [CONFIGURATION](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#configuration)

# 表达式查询

- https://prometheus.io/docs/prometheus/latest/querying/basics/#querying-prometheus

# 指令和Expole

- https://prometheus.io/docs/guides/node-exporter/

