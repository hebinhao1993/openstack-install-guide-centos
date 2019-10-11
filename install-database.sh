#!/usr/bin/env bash
set -e 
yum install -y mariadb mariadb-server python2-PyMySQL

if [ -e /etc/my.cnf.d/openstack.cnf ]; then
    rm /etc/my.cnf.d/openstack.cnf
fi
cat << EOF >> /etc/my.cnf.d/openstack.cnf
[mysqld]
bind-address = 10.0.2.4

default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
EOF

systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation

echo "install database done"