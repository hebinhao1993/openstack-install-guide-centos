#!/usr/bin/env bash
systemctl restart network
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
sed -i 's/=enforcing/=permissive/' /etc/selinux/config