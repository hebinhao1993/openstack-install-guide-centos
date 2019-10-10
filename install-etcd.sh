#!/usr/bin/env bash
set -e
yum install -y etcd

sed -i -e 's/^#ETCD_DATA_DIR/ETCD_DATA_DIR/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_DATA_DIR.*/ETCD_DATA_DIR="\/var\/lib\/etcd\/default.etcd"/' /etc/etcd/etcd.conf


sed -i -e 's/^#ETCD_LISTEN_PEER_URLS/ETCD_LISTEN_PEER_URLS/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_LISTEN_PEER_URLS.*/ETCD_LISTEN_PEER_URLS="http:\/\/10.0.2.4:2380"/' /etc/etcd/etcd.conf


sed -i -e 's/^#ETCD_LISTEN_CLIENT_URLS/ETCD_LISTEN_CLIENT_URLS/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_LISTEN_CLIENT_URLS.*/ETCD_LISTEN_CLIENT_URLS="http:\/\/10.0.2.4:2379"/' /etc/etcd/etcd.conf

sed -i -e 's/^#ETCD_NAME/ETCD_NAME/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_NAME.*/ETCD_NAME="controller"/' /etc/etcd/etcd.conf

sed -i -e 's/^#ETCD_INITIAL_ADVERTISE_PEER_URLS/ETCD_INITIAL_ADVERTISE_PEER_URLS/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_INITIAL_ADVERTISE_PEER_URLS.*/ETCD_INITIAL_ADVERTISE_PEER_URLS="http:\/\/10.0.2.4:2380"/' /etc/etcd/etcd.conf

sed -i -e 's/^#ETCD_ADVERTISE_CLIENT_URLS/ETCD_ADVERTISE_CLIENT_URLS/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_ADVERTISE_CLIENT_URLS.*/ETCD_ADVERTISE_CLIENT_URLS="http:\/\/10.0.2.4:2379"/' /etc/etcd/etcd.conf

sed -i -e 's/^#ETCD_INITIAL_CLUSTER/ETCD_INITIAL_CLUSTER/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_INITIAL_CLUSTER.*/ETCD_INITIAL_CLUSTER="controller=http:\/\/10.0.2.4:2380"/' /etc/etcd/etcd.conf

sed -i -e 's/^#ETCD_INITIAL_CLUSTER_TOKEN/ETCD_INITIAL_CLUSTER_TOKEN/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_INITIAL_CLUSTER_TOKEN.*/ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"/' /etc/etcd/etcd.conf

sed -i -e 's/^#ETCD_INITIAL_CLUSTER_STATE/ETCD_INITIAL_CLUSTER_STATE/' /etc/etcd/etcd.conf
sed -i -e 's/^ETCD_INITIAL_CLUSTER_STATE.*/ETCD_INITIAL_CLUSTER_STATE="new"/' /etc/etcd/etcd.conf

systemctl enable etcd
systemctl start etcd

echo "install etcd done"