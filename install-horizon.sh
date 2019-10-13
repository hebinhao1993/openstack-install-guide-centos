#!/usr/bin/env bash
set -e

yum install openstack-dashboard

# backup /etc/openstack-dashboard/local_settings
if [ -e /etc/openstack-dashboard/local_settings.backup ]; then
    cp /etc/openstack-dashboard/local_settings.backup /etc/openstack-dashboard/local_settings
else
    cp /etc/openstack-dashboard/local_settings /etc/openstack-dashboard/local_settings.backup
fi
# edit /etc/openstack-dashboard/local_settings
cat local_settings > /etc/openstack-dashboard/local_settings

# /etc/httpd/conf.d/openstack-dashboard.conf
if [ -e /etc/httpd/conf.d/openstack-dashboard.conf.backup ]; then
    cp /etc/httpd/conf.d/openstack-dashboard.conf.backup /etc/httpd/conf.d/openstack-dashboard.conf
else
    cp /etc/httpd/conf.d/openstack-dashboard.conf /etc/httpd/conf.d/openstack-dashboard.conf.backup
fi
# edit /etc/httpd/conf.d/openstack-dashboard.conf
cat openstack-dashboard.conf > /etc/httpd/conf.d/openstack-dashboard.conf

systemctl restart httpd.service memcached.service