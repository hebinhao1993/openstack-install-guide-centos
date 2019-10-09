#!/usr/bin/env bash

yum install -y chrony
if [ -e /etc/chrony.conf.back ]; then
    cp /etc/chrony.conf.backup /etc/chrony.conf
else
    cp /etc/chrony.conf /etc/chrony.conf.backup
fi
sed -i -n -e 's/centos.pool.ntp.org/cn.pool.ntp.org/gp'  /etc/chrony.conf
sed -i -n -e 's/\#allow 192.168.0.0\/16/allow 10.0.2.0\/16/p'  /etc/chrony.conf
systemctl enable chronyd.service
systemctl start chronyd.service