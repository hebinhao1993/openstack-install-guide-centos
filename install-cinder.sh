#!/usr/bin/env bash
set -e 

yum install -y openstack-cinder

# backup /etc/cinder/cinder.conf
if [ -e /etc/cinder/cinder.conf.backup ]; then
    cp /etc/cinder/cinder.conf.backup /etc/cinder/cinder.conf
else
    cp /etc/cinder/cinder.conf /etc/cinder/cinder.conf.backup
fi
# edit /etc/cinder/cinder.conf
cat cinder.conf > /etc/cinder/cinder.conf

# here we do not edit /etc/nova/nova.conf, since we have edited it when nova is installed
# ...

systemctl restart openstack-nova-api.service
systemctl enable openstack-cinder-api.service openstack-cinder-scheduler.service
systemctl start openstack-cinder-api.service openstack-cinder-scheduler.service

echo "install cinder on controller node Done!"
