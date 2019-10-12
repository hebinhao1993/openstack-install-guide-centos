#!/usr/bin/env bash
set -e

# we select the option2: self-service networks

# install packages
yum install openstack-neutron openstack-neutron-ml2 openstack-neutron-linuxbridge ebtables

# backup /etc/neutron/neutron.conf
if [ -e /etc/neutron/neutron.conf.backup ]; then
    cp /etc/neutron/neutron.conf.backup /etc/neutron/neutron.conf 
else
    cp /etc/neutron/neutron.conf /etc/neutron/neutron.conf.backup
fi
# edit /etc/neutron/neutron.conf
# ...

# Configure the Modular Layer 2 (ML2) plug-in
# /etc/neutron/plugins/ml2/ml2_conf.ini
# ...

# Configure the Linux bridge agent
# /etc/neutron/plugins/ml2/linuxbridge_agent.ini\
# ...

# Configure the DHCP agent
# /etc/neutron/dhcp_agent.ini
# ...