#!/usr/bin/env bash
mysql -u root -p123456 < keystone.sql
yum install -y openstack-keystone httpd mod_wsgi