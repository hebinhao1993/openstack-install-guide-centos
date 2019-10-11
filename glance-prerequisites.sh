#!/usr/bin/env bash
mysql -uroot -p123456 < glance.sql
# shellcheck disable=SC1091
source admin-openrc
openstack user create --domain default --password 123456 glance
# openstack user create --domain default --password-prompt glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292