#!/usr/bin/env bash
set -e

yum install -y lvm2 device-mapper-persistent-data
systemctl enable lvm2-lvmetad.service
systemctl start lvm2-lvmetad.service
pvcreate /dev/sdb
vgcreate cinder-volumes /dev/sdb

# Edit the /etc/lvm/lvm.conf 
# ...

yum install -y  openstack-cinder targetcli python-keystone

# edit /etc/cinder/cinder.conf

# Finalize installation
systemctl enable openstack-cinder-volume.service target.service
systemctl start openstack-cinder-volume.service target.service