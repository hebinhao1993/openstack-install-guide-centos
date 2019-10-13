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
cat neutron-compute.conf > /etc/neutron/neutron.conf
 
# backup /etc/neutron/plugins/ml2/linuxbridge_agent.ini
if [ -e /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup ]; then
    cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup /etc/neutron/plugins/ml2/linuxbridge_agent.ini
else
    cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup
fi
# edit /etc/neutron/plugins/ml2/linuxbridge_agent.ini
cat linuxbridge_agent-compute.ini > /etc/neutron/plugins/ml2/linuxbridge_agent.ini

# Ensure your Linux operating system kernel supports network bridge filters by verifying all the following sysctl values are set to 1:
# net.bridge.bridge-nf-call-iptables
# net.bridge.bridge-nf-call-ip6tables
# modprobe br_netfilter

# finalize installation
systemctl restart openstack-nova-compute.service
systemctl enable neutron-linuxbridge-agent.service
systemctl start neutron-linuxbridge-agent.service