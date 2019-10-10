#!/usr/bin/env bash
if [ -e /etc/hosts.backup ]; then
    cp /etc/hosts.backup /etc/hosts
else
    cp /etc/hosts /etc/hosts.backup
fi

cat << EOF >> /etc/hosts
10.0.2.4 controller
10.0.2.5 compute1
EOF