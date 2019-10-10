#!/usr/bin/env bash
set -e

yum install -y rabbitmq-server
systemctl enable rabbitmq-server.service
systemctl start rabbitmq-server.service
# Add the openstack user:
rabbitmqctl add_user openstack 123456
# Permit configuration, write, and read access for the openstack user:
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

echo "install rabbitmq done"