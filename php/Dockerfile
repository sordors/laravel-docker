FROM php:7.3.2-fpm

ARG APT_LIST

#添加镜像源
ADD $APT_LIST /opt/
# 安装扩展包

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \ 
    && cat /opt/$APT_LIST >/etc/apt/sources.list \ 
    && apt-get update && apt-get install -y libzip-dev zip libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev cron supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install gd mysqli pdo_mysql zip opcache bcmath iconv


RUN pecl install redis-4.2.0 \
    && pecl install mcrypt-1.0.2 \
    && pecl install swoole-4.2.9 \
    && docker-php-ext-enable redis swoole mcrypt

#其他基础命令
RUN mkdir -p /var/log/supervisor\
    && mkdir -p /www \
    && chown -R www-data:www-data /www \
    && /etc/init.d/cron start

WORKDIR /www

#安装composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# 修改 composer 为国内镜像
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer

#扩展配置*.ini
COPY ./conf.d/opcache.ini /usr/local/etc/php/
COPY ./conf.d/phpcustom.ini /usr/local/etc/php/

CMD ["/usr/bin/supervisord"]