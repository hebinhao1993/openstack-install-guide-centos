#!/usr/bin/env bash
set -e

yum install -y openstack-glance
# backup /etc/glance/glance-api.conf
if [ -e /etc/glance/glance-api.conf.backup ]; then
    cp /etc/glance/glance-api.conf.backup /etc/glance/glance-api.conf
else
    cp /etc/glance/glance-api.conf /etc/glance/glance-api.conf.backup
fi
# modify /etc/glance/glance-api.conf
cat glance-api.conf > /etc/glance/glance-api.conf

# backup /etc/glance/glance-registry.conf
if [ -e /etc/glance/glance-registry.conf.backup ]; then
    cp /etc/glance/glance-registry.conf.backup /etc/glance/glance-registry.conf
else
    cp /etc/glance/glance-registry.conf /etc/glance/glance-registry.conf.backup
fi
# modify /etc/glance/glance-registry.conf
cat glance-registry.conf > /etc/glance/glance-registry.conf

su -s /bin/sh -c "glance-manage db_sync" glance
systemctl enable openstack-glance-api.service openstack-glance-registry.service
systemctl start openstack-glance-api.service openstack-glance-registry.service
echo "install glance complete!"