#!/usr/bin/env bash
set -e
yum install -y chrony
if [ -e /etc/chrony.conf.backup ]; then
    cp /etc/chrony.conf.backup /etc/chrony.conf
else
    cp /etc/chrony.conf /etc/chrony.conf.backup
fi
# point to controller
sed -i -e 's/0.centos.pool.ntp.org/controller/'  /etc/chrony.conf
# comment others
sed -i -e 's/server 1.centos.pool.ntp.org iburst/#server 1.centos.pool.ntp.org iburst/' /etc/chrony.conf
sed -i -e 's/server 2.centos.pool.ntp.org iburst/#server 2.centos.pool.ntp.org iburst/' /etc/chrony.conf
sed -i -e 's/server 3.centos.pool.ntp.org iburst/#server 3.centos.pool.ntp.org iburst/' /etc/chrony.conf
systemctl enable chronyd.service
systemctl start chronyd.service
echo "install chrony done"