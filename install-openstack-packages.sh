#!/usr/bin/env bash
yum install -y centos-release-openstack-rocky
yum upgrade
yum install -y python-openstackclient
yum install -y openstack-selinux