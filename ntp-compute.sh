#!/usr/bin/env bash

yum install -y chrony

systemctl enable chronyd.service
systemctl start chronyd.service