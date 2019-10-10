#!/usr/bin/env bash
set -e

yum install -y memcached python-memcached
sed -i -e 's/OPTIONS="-l 127.0.0.1,::1"/OPTIONS="-l 127.0.0.1,::1,controller"/' /etc/sysconfig/memcached
systemctl enable memcached.service
systemctl start memcached.service

echo "install memcached done."