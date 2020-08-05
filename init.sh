#!/usr/bin/env bash

set -x \
&& rm -rf /etc/nginx \
&& rm -rf /etc/supervisor \
&& mkdir /run/php

set -x \
&& cp -r "/usr/share/container_config/nginx" /etc/nginx \
&& cp -r "/usr/share/container_config/supervisor" /etc/supervisor

sed -i "s/EMAIL_HOST/$EMAIL_HOST/g" /etc/nginx/sites/email.conf

sed -i "s/error_log = \/var\/log\/php7.4-fpm.log/error_log = \/dev\/stdout/g" /etc/php/7.4/fpm/php-fpm.conf
sed -i "s/;error_log = syslog/error_log = \/dev\/stdout/g" /etc/php/7.4/fpm/php.ini
sed -i "s/;error_log = syslog/error_log = \/dev\/stdout/g" /etc/php/7.4/cli/php.ini
sed -i "s/log_errors = Off/log_errors = On/g" /etc/php/7.4/cli/php.ini
sed -i "s/log_errors = Off/log_errors = On/g" /etc/php/7.4/fpm/php.ini
sed -i "s/log_errors_max_len = 1024/log_errors_max_len = 0/g" /etc/php/7.4/cli/php.ini
sed -i "s/user = www-data/user = email/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = email/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/pm = dynamic/pm = static/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/pm.max_children = 5/pm.max_children = ${PHP_PM_MAX_CHILDREN}/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/;pm.max_requests = 500/pm.max_requests = ${PHP_PM_MAX_REQUESTS}/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/listen.owner = www-data/listen.owner = email/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/listen.group = www-data/listen.group = email/g" /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s/;catch_workers_output = yes/catch_workers_output = yes/g" /etc/php/7.4/fpm/pool.d/www.conf

sed -i "s/EMAIL_HOST/$EMAIL_HOST/g" /opt/email/src/Gateway.php
sed -i "s/EMAIL_FROM/$EMAIL_FROM/g" /opt/email/src/Resource/config/resources_shared.php
sed -i "s/SMTP_HOST/$SMTP_HOST/g" /opt/email/src/Resource/config/resources_shared.php
sed -i "s/SMTP_PORT/$SMTP_PORT/g" /opt/email/src/Resource/config/resources_shared.php
sed -i "s/SMTP_USERNAME/$SMTP_USERNAME/g" /opt/email/src/Resource/config/resources_shared.php
sed -i "s/SMTP_PASSWORD/$SMTP_PASSWORD/g" /opt/email/src/Resource/config/resources_shared.php
sed -i "s/SMTP_ENCRYPTION/$SMTP_ENCRYPTION/g" /opt/email/src/Resource/config/resources_shared.php
sed -i "s/SMTP_TIMEOUT/$SMTP_TIMEOUT/g" /opt/email/src/Resource/config/resources_shared.php

touch /node_status_inited
