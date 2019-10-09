#!/usr/bin/env bash
yum install centos-release-openstack-rocky
yum upgrade
yum install python-openstackclient
yum install openstack-selinux