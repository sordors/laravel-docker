# laravel-docker

## 项目说明
适用本地开发laravel项目的环境

## 环境说明

* mysql     8.0.13
* php-fpm   7.1.24
* redis     5.0.3
* nginx     1.15.7
* supervisor

## 基本要求
1. 掌握supervisor的配置
2. 掌握redis配置
3. 掌握mysql的配置
4. 掌握nginx的配置
5. 掌握docker的使用方法

## 注意事项
1. 为了快速搭建镜像,推荐使用国内镜像加速,[教程](https://blog.csdn.net/sinat_32247833/article/details/79767263)
2. 请确保虚拟机有共享本项目所在的文件夹

## 目录结构描述
```
├── Readme.md                    // help
├── www                          // 存放应用的目录
├── nginx                        
│   ├── conf.d                   // 配置
│   ├── log                      // 日志
│   └──nginx.conf                // 配置
├── php
│   ├── conf.d                   // 配置
│   ├── apt-list                 // 镜像加速配置
│   ├── crontab                  // 定时调度配置
│   └── Dockerfile               // dockerfile
├── redis                        //配置
├── www                          //代码存放目录
├── supervisor
│   ├── conf.d                   // 配置
│   └── log                      // 日志
└── .env.example                //环境配置例子
```

## 使用方法
* 复制.env.example 文件为 .env 文件

* 修改.env文件

```
    # 项目名称
    APP_NAME=app
    
    # 修改项目路径,该路径为虚拟机共享目录内的文件名
    # 假设虚拟机共享目录为www,该项目在www目录内的app,修改如下:
    APP_PATH=www/app

    # 修改代码路径,代码只允许存放在当前文件夹的www目录
    # 假设代码路径在www目录内的laravel,修改如下:
    APP_CODE_PATH=laravel

    # mysql配置
    MYSQL_ROOT_PASSWORD=root        //密码
    MYSQL_PORTS=3306                //暴露端口

    # REDIS 密码配置
    # 可在redis/redis.conf下修改requirepass 参数,默认密码为root
    # REDIS 基础配置
    REDIS_PORTS=6379                //暴露端口
    
    # NGINX 配置
    NGINX_PORTS=80                  //指定nginx暴露的80端口
    NGINX_SSL_PORTS=443             //指定nginx暴露的443端口
    NGINX_SUPERVISOR_PORTS=8080     //指定nginx暴露的8080端口，用于查看supervisor的管理页面
```

* 配置 laravel .env 文件

```
    # REDIS 配置
    REDIS_CLIENT=phpredis
    REDIS_HOST=redis
    REDIS_PASSWORD=root
    REDIS_PORT=6379

    # MYSQL 配置
    DB_CONNECTION=mysql
    DB_HOST=db
    DB_PORT=3306
    DB_DATABASE=xxx   //自行连接mysql创建
    DB_USERNAME=root
    DB_PASSWORD=root

```

* 启动

```
    docker-compose up -d
```

* 查看进程

```
    docker-compose ps
```
* 访问

```
    http://192.168.99.100
```

* 关闭

```
    docker-compose down
```

