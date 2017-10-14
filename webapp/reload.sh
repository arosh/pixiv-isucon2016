#!/bin/bash
set -ex
now=`date +%Y%m%d-%H%M%S`
if [ -e /var/log/nginx/access.log ]; then
  mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
fi

if [ -e /var/log/mysql/mysql-slow.log ]; then
  mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$now
fi

if [ "$(pgrep mysql | wc -l)" ]; then  
  mysqladmin -uroot flush-logs
fi

cp conf/nginx.conf /etc/nginx/nginx.conf
systemctl reload nginx

cp conf/my.cnf /etc/mysql/my.cnf
systemctl restart mysql

cp conf/isu-python.service /etc/systemd/system/isu-python.service
systemctl daemon-reload
systemctl restart isu-python

journalctl -f -u nginx -u mysql -u isu-python
