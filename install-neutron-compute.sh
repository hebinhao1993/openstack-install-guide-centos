#!/usr/bin/env bash
set -e

yum install -y openstack-neutron-linuxbridge ebtables ipset

# backup /etc/neutron/neutron.conf
if [ -e /etc/neutron/neutron.conf.backup ]; then
    cp /etc/neutron/neutron.conf.backup /etc/neutron/neutron.conf 
else
    cp /etc/neutron/neutron.conf /etc/neutron/neutron.conf.backup
fi
# edit the /etc/neutron/neutron.conf
cat neutron.conf > /etc/neutron/neutron.conf

# edit the /etc/nova/nova.conf

# finalize installation
systemctl restart openstack-nova-compute.service
systemctl enable neutron-linuxbridge-agent.service
systemctl start neutron-linuxbridge-agent.service