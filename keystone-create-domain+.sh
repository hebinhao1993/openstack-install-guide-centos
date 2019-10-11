#!/usr/bin/env bash
set -e
echo "start"
openstack domain create --description "An Example Domain" example
openstack project create --domain default --description "Service Project" service
openstack project create --domain default --description "Demo Project" myproject
openstack user create --domain default --password-prompt myuser
openstack role create myrole
openstack role add --project myproject --user myuser myrole
echo "compelte create project user and role."