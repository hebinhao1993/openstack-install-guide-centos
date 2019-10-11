#!/usr/bin/env bash
set -e
mysql -u root -p123456 < keystone.sql
yum install -y openstack-keystone httpd mod_wsgi

backup /etc/keystone/keystone.conf
if [ -e /etc/keystone/keystone.conf.backup ]; then
    cp /etc/keystone/keystone.conf.backup /etc/keystone/keystone.conf
else
    cp /etc/keystone/keystone.conf /etc/keystone/keystone.conf.backup
fi
cat keystone.conf > /etc/keystone/keystone.conf
su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
keystone-manage bootstrap --bootstrap-password 123456 \
  --bootstrap-admin-url http://controller:5000/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne
# backup /etc/httpd/conf/httpd.conf
if [ -e /etc/httpd/conf/httpd.conf.backup ]; then
    cp /etc/httpd/conf/httpd.conf.conf.backup /etc/httpd/conf/httpd.conf
else
    cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.conf.backup
fi
# edit /etc/httpd/conf/httpd.conf 
# ServerName controller
sed -i -e 's/^#ServerName www.example.com:80/ServerName Controller/' /etc/httpd/conf/httpd.conf

ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
# Finalize the installation
systemctl enable httpd.service
systemctl start httpd.service

echo "keystone install done"
