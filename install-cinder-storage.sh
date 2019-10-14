#!/usr/bin/env bash
set -e

yum install -y lvm2 device-mapper-persistent-data
systemctl enable lvm2-lvmetad.service
systemctl start lvm2-lvmetad.service
pvcreate /dev/sdb
vgcreate cinder-volumes /dev/sdb

# backup the /etc/lvm/lvm.conf 
if [ -e /etc/lvm/lvm.conf.backup ]; then
    cp /etc/lvm/lvm.conf.backup /etc/lvm/lvm.conf
else
    cp /etc/lvm/lvm.conf /etc/lvm/lvm.conf.backup
fi
# edit /etc/lvm/lvm.conf
cat lvm.conf > /etc/lvm/lvm.conf

yum install -y  openstack-cinder targetcli python-keystone

# backup /etc/cinder/cinder.conf
if [ -e /etc/cinder/cinder.conf.backup ]; then
    cp /etc/cinder/cinder.conf.backup /etc/cinder/cinder.conf
else
    cp /etc/cinder/cinder.conf /etc/cinder/cinder.conf.backup
fi
# edit /etc/cinder/cinder.conf
cat cinder-storage.conf > /etc/cinder/cinder.conf
echo "modify /etc/cinder/cinder.conf"

# Finalize installation
systemctl enable openstack-cinder-volume.service target.service
systemctl start openstack-cinder-volume.service target.service

echo "finish install cinder on storage node!"