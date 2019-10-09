#!/usr/bin/env bash

yum install -y chrony
if [ -e /etc/chrony.conf.backup ]; then
    cp /etc/chrony.conf.backup /etc/chrony.conf
else
    cp /etc/chrony.conf /etc/chrony.conf.backup
fi
sed -i -e 's/centos.pool.ntp.org/cn.pool.ntp.org/g'  /etc/chrony.conf
# if not use the script, than use the commented command
#sed -n -e 's/centos.pool.ntp.org/cn.pool.ntp.org/gp'  /etc/chrony.conf
sed -i -e 's/\#allow 192.168.0.0\/16/allow 10.0.2.0\/16/'  /etc/chrony.conf
# if not use the script, than use the commented command
#sed -n -e 's/\#allow 192.168.0.0\/16/allow 10.0.2.0\/16/p'  /etc/chrony.conf
systemctl enable chronyd.service
systemctl start chronyd.service