#!/usr/bin/env bash
set -e 

yum install -y openstack-cinder

# backup /etc/cinder/cinder.conf
# edit /etc/cinder/cinder.conf

# here we do not edit /etc/nova/nova.conf, since we have edited it when nova is installed
# ...

systemctl restart openstack-nova-api.service
systemctl enable openstack-cinder-api.service openstack-cinder-scheduler.service
systemctl start openstack-cinder-api.service openstack-cinder-scheduler.service