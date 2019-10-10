#!/usr/bin/env bash
yum install -y mariadb mariadb-server python2-PyMySQL

if [ -e /etc/my.cnf.d/openstack.cnf ]; then
    rm /etc/my.cnf.d/openstack.cnf
fi
cat << EOF >> /etc/my.cnf.d/openstack.cnf
bind-address = 10.10.2.15
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