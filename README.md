# laravel-docker

## 项目说明
利用docker部署一套稳定的环境,减少配置环境的出错率及重复率

## 环境说明

* mysql     8.0
* php-fpm   7.3
* redis     5.0
* nginx     1.17
* supervisor

## 基本要求
1. 掌握supervisor的配置
2. 掌握redis配置
3. 掌握mysql的配置
4. 掌握nginx的配置
5. 掌握docker的使用方法
6. 安装docker和docker-compose


## 目录结构描述
```
├── Readme.md                    // help
├── www                          // 存放应用的目录
├── log                          // 日志
├── nginx                        
│   ├── conf.d                   // 配置
│   └──nginx.conf                // 配置
├── php
│   ├── conf.d                   // php环境配置
│   ├── apt-list                 // 镜像加速配置
│   ├── crontab                  // 定时调度配置
│   ├── Dockerfile               // dockerfile
│   └── supervisor.d             //配置
├── redis                        //配置
├── www                          //代码存放目录
└── .env.example                //环境配置例子
```
## 修改镜像源
```
    vi /etc/docker/daemon.json
	文件中加入：
	{
		"registry-mirrors":["https://docker.mirrors.ustc.edu.cn"]
	}
	然后重启守护进程
	systemctl daemon-reload
	systemctl restart docker
```


## 使用方法
* 复制.env.example 文件为 .env 文件
```
    cp -r .env.example .env
```
* 修改.env文件
```
    vi .env
```

```
    # 项目名称(用于区分容器归属项目)
    APP_NAME=app
    
    # 修改项目路径,路径为磁盘根目录起的位置
    # 假设在磁盘根目录有www目录,该项目存放于该目录内,修改如下:
    APP_PATH=www/laravel-docker

    # 修改代码路径,代码只允许存放在当前文件夹的www目录
    # 假设代码路径在www/laravel-docker/www/laravel,修改如下:
    APP_CODE_PATH=laravel

    # mysql配置
    MYSQL_ROOT_PASSWORD=root        //密码
    MYSQL_PORTS=3306                //暴露端口

    # REDIS 密码配置
    # 可在redis/redis.conf下修改requirepass 参数,默认密码为root
    # REDIS 基础配置
    REDIS_PORTS=6379                //暴露端口
    
    # NGINX 配置
    NGINX_PORTS=8080                  //指定nginx暴露的8080端口
```

* 配置 laravel .env 文件

```
    # REDIS 配置
    REDIS_CLIENT=phpredis
    REDIS_HOST=redis
    REDIS_PASSWORD=root
    REDIS_PORT=6379

    # 使用MYSQL 配置
    DB_CONNECTION=mysql
    DB_HOST=db
    DB_PORT=3306
    DB_DATABASE=xxx   //自行连接mysql创建
    DB_USERNAME=root
    DB_PASSWORD=root

```
* mysql8.0说明

```
    在laravel 项目中,建议关闭严格模式
    修改laravel 项目中 config/database.php 下的mysql数组
    其中 strict 默认为true ，修改成false
    
    'mysql' => [
            'driver' => 'mysql',
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '3306'),
            'database' => env('DB_DATABASE', 'forge'),
            'username' => env('DB_USERNAME', 'forge'),
            'password' => env('DB_PASSWORD', ''),
            'unix_socket' => env('DB_SOCKET', ''),
            'charset' => 'utf8mb4',
            'collation' => 'utf8mb4_unicode_ci',
            'prefix' => '',
            'prefix_indexes' => false,
            'strict' => false,
            'engine' => null,
        ],
```

* 启动

```
    docker-compose up -d
```

* 查看进程

```
    docker-compose ps
```
* 访问说明

```
    服务器ip:8080 确保服务器访问安全组有配置8080端口开放权限
    域名：正常域名使用的是80端口,自行在系统安装nginx并转发至.env配置中NGINX_PORTS 的端口
```

* 关闭

```
    docker-compose down
```

