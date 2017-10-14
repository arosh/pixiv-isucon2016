#!/bin/bash
set -e
now=`date +%Y%m%d-%H%M%S`
#mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
#mv /var/log/mysql/slow.log /var/log/mysql/mysql.log.$now
mysqladmin -uroot flush-logs

cp conf/nginx.conf /etc/nginx/nginx.conf
systemctl reload nginx

cp conf/my.cnf /etc/mysql/my.cnf
systemctl restart mysql

#systemctl restart isutar.python isuda.python
journalctl -f -u nginx -u mysql
