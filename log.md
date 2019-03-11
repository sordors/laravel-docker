# 踩坑记录

## MYSQL

### 踩坑时间2019-3-12,花费时间6个小时

```
    docker-compose logs db
    # 显示报错
    mysqld: [Warning] World-writable config file '/etc/mysql/conf.d/my.cnf' is ignored.
    # 由于mysql担心这种文件被其他用户恶意修改，所以忽略掉这个配置文件
    # linux 解决方案
    chmod 644 /etc/my.cnf
    # Windows 解决方案右键设置为只读
```

## PHP

### 踩坑时间很早以前

```
    多进程启动容器,导致进程退出
    # 解决方案
    使用supervisor启动多进程
    thinkphp版本由于没有定时任务以及队列,问题无
```
