#!/usr/bin/env bash
set -e
export OS_USERNAME=admin
export OS_PASSWORD=123456 # this password is the password used in keystone-manage bootstrap
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3