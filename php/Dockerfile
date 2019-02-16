FROM php:7.3.2-fpm

MAINTAINER 960905282@qq.com

#添加阿里云镜像
ADD apt-list /opt/

# 安装扩展包

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \ 
    && cat /opt/apt-list >/etc/apt/sources.list \ 
    && apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev cron supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli pdo_mysql zip opcache


RUN pecl install redis-4.2.0 \
    && pecl install swoole-4.2.9 \
    && docker-php-ext-enable redis swoole

#创建supervisor为容器启动多进程
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /www
WORKDIR /www
#配置定时任务

# 复制配置文件 /var/spool/cron/crontabs/

COPY ./crontab /var/spool/cron/crontabs/root
# 设置文件所有者和文件关联组为 root:crontab ，关联组必须为 crontab
RUN chown -R root:crontab /var/spool/cron/crontabs/root \
    && chmod 600 /var/spool/cron/crontabs/root \
    && touch /var/log/cron.log \
    && crontab /var/spool/cron/crontabs/root


#扩展配置*.ini

COPY ./conf.d/opcache.ini /usr/local/etc/php/
COPY ./conf.d/phpcustom.ini /usr/local/etc/php/

CMD ["/usr/bin/supervisord"]