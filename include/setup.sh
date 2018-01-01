#!/bin/bash

# Setup xdebug
mkdir -p /tmp/xdebug/profiler && chmod -R 664 /tmp/xdebug/profiler
touch /tmp/xdebug/xdebug.log && chmod 664 /tmp/xdebug/xdebug.log
sed -i  "s/{DOCKER_HOST_IP}/$DOCKER_HOST_IP/g" /root/php_xdebug.ini

# Copy config files
cp /root/httpd.conf /etc/httpd/conf/httpd.conf
cp /root/php_xdebug.ini /etc/php.d/php_xdebug.ini

# Set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

# Start memcached
/usr/bin/memcached -u memcached -p 11211 -m 128 -c 1024 &

# Start httpd
/usr/sbin/apachectl -DFOREGROUND