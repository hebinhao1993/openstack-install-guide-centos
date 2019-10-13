#!/usr/bin/env bash
set -e

# we select the option2: self-service networks

# install packages
yum install -y openstack-neutron openstack-neutron-ml2 openstack-neutron-linuxbridge ebtables

# backup /etc/neutron/neutron.conf
if [ -e /etc/neutron/neutron.conf.backup ]; then
    cp /etc/neutron/neutron.conf.backup /etc/neutron/neutron.conf 
else
    cp /etc/neutron/neutron.conf /etc/neutron/neutron.conf.backup
fi
# edit /etc/neutron/neutron.conf
cat neutron.conf > /etc/neutron/neutron.conf


# Configure the Modular Layer 2 (ML2) plug-in
# backup /etc/neutron/plugins/ml2/ml2_conf.ini
if [ -e /etc/neutron/plugins/ml2/ml2_conf.ini.backup ]; then
    cp /etc/neutron/plugins/ml2/ml2_conf.ini.backup /etc/neutron/plugins/ml2/ml2_conf.ini
else
    cp /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini.backup
fi
# edit /etc/neutron/plugins/ml2/ml2_conf.ini
cat ml2_conf.ini > /etc/neutron/plugins/ml2/ml2_conf.ini

# Configure the Linux bridge agent
# backup /etc/neutron/plugins/ml2/linuxbridge_agent.ini
if [ -e /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup ]; then
    cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup /etc/neutron/plugins/ml2/linuxbridge_agent.ini
else
    cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup
fi
# edit /etc/neutron/plugins/ml2/linuxbridge_agent.ini
cat linuxbridge_agent.ini > /etc/neutron/plugins/ml2/linuxbridge_agent.ini

# Configure the DHCP agent
# backup /etc/neutron/dhcp_agent.ini
if [ -e /etc/neutron/dhcp_agent.ini.backup ]; then
    cp /etc/neutron/dhcp_agent.ini.backup /etc/neutron/dhcp_agent.ini 
else
    cp /etc/neutron/dhcp_agent.ini /etc/neutron/dhcp_agent.ini.backup
fi
# edit /etc/neutron/dhcp_agent.ini
cat dhcp_agent.ini > /etc/neutron/dhcp_agent.ini