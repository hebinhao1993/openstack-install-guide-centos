#!/usr/bin/env bash
set -e
mysql -u root -p123456 < keystone.sql
yum install -y openstack-keystone httpd mod_wsgi

# backup /etc/keystone/keystone.conf
# if [ -e /etc/keystone/keystone.conf.backup ]; then
#     cp /etc/keystone/keystone.conf.backup /etc/keystone/keystone.conf
# else
#     cp /etc/keystone/keystone.conf /etc/keystone/keystone.conf.backup
# fi
# rm /etc/keystone/keystone.conf
# edit /etc/keystone/keystone.conf
# ...
# ...
