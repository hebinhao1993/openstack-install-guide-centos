#!/usr/bin/env bash
set -e
yum install -y centos-release-openstack-rocky
yum upgrade
yum install -y python-openstackclient
yum install -y openstack-selinux
echo 'install openstack packages complete!'