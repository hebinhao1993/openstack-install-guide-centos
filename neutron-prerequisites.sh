#!/usr/bin/env bash
mysql -uroot -p123456 < neutron.sql
# shellcheck disable=SC1091
source admin-openrc
openstack user create --domain default --password 123456 neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region RegionOne network public http://controller:9696
openstack endpoint create --region RegionOne network internal http://controller:9696
openstack endpoint create --region RegionOne network admin http://controller:9696
