#!/usr/bin/env bash
set -e

# install the packages
yum install -y openstack-nova-compute

# back up /etc/nova/nova.conf 
if [ -e /etc/nova/nova.conf.backup ]; then
    cp /etc/nova/nova.conf.backup /etc/nova/nova.conf 
else
    cp /etc/nova/nova.conf /etc/nova/nova.conf.backup
fi
# modify /etc/nova/nova.conf
cat nova.compute.conf > /etc/nova/nova.conf

systemctl enable libvirtd.service openstack-nova-compute.service
systemctl start libvirtd.service openstack-nova-compute.service

echo "install nova-compute done!"
