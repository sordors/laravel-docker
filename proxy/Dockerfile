FROM php:7.3.2-fpm

MAINTAINER Mr.angel <960905282@qq.com>

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#添加阿里云镜像
ADD apt-list /opt/

# 安装扩展包

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \ 
    && cat /opt/apt-list >/etc/apt/sources.list \ 
    && apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev supervisor \
    && rm -rf /var/lib/apt/lists/* 

RUN pecl install swoole-4.2.9 \
    && docker-php-ext-enable swoole

#创建supervisor为容器启动多进程
RUN mkdir -p /var/log/supervisor

CMD ["/usr/bin/supervisord"]