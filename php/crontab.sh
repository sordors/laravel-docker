#!/bin/sh
cpid=`pidof cron |awk '{print $1}'`
if [ ${cpid} ]; then
  echo 'The process has started'
else
  echo 'start process start'
  /etc/init.d/cron start
fi

sleep 5

cpid=`pidof cron |awk '{print $1}'`

if [ ${cpid} ]; then
  echo 'add cron'
  echo -e "* * * * * /usr/local/bin/php /www/artisan schedule:run >> /dev/null 2>&1\n* * * * * env > /www/storage/logs/laravel-cron.txt" >> conf && crontab conf && rm -f conf
fi