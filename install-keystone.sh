#!/usr/bin/env bash
set -e
mysql -u root -p123456 < keystone.sql
yum install -y openstack-keystone httpd mod_wsgi
# edit /etc/keystone/keystone.conf
if [ -e /etc/keystone/keystone.conf.backup ]; then
    cp /etc/chrony.conf.backup /etc/chrony.conf
else
    cp /etc/chrony.conf /etc/chrony.conf.backup
fi
sed -i -e 's/#connection =.*/connection = mysql+pymysql://keystone:123456@controller/keystone' /etc/keystone/keystone.conf
su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
  --bootstrap-admin-url http://controller:5000/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne
# edit /etc/httpd/conf/httpd.conf 
# ...
ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
# Finalize the installation
systemctl enable httpd.service
systemctl start httpd.service
