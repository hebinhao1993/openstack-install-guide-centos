#!/usr/bin/env bash
set -e
mysql -uroot -p123456 < glance.sql
. admin-openrc
openstack user create --domain default --password 123456 glance
# openstack user create --domain default --password-prompt glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

sudo -v
sudo yum install -y openstack-glance
sudo su -s /bin/sh -c "glance-manage db_sync" glance
sudo systemctl enable openstack-glance-api.service openstack-glance-registry.service
sudo systemctl start openstack-glance-api.service openstack-glance-registry.service