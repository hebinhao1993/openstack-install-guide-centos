#!/usr/bin/env bash
set -e

# install the packages
yum install openstack-nova-api openstack-nova-conductor openstack-nova-console openstack-nova-novncproxy openstack-nova-scheduler openstack-nova-placement-api

# back up /etc/nova/nova.conf 
if [ -e /etc/nova/nova.conf.backup ]; then
    cp /etc/nova/nova.conf.backup /etc/nova/nova.conf 
else
    cp /etc/nova/nova.conf.conf /etc/nova/nova.conf.backup
fi
# modify /etc/nova/nova.conf
cat nova.conf > /etc/nova/nova.conf

#
su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova
systemctl enable openstack-nova-api.service openstack-nova-consoleauth openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service
systemctl start openstack-nova-api.service openstack-nova-consoleauth openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service