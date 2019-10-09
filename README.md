# openstack install guide

这是一份openstack的安装指南，操作系统是centos7。使用virtualbox虚拟机来搭建。为了方便起见，后文但凡出现的密码，均使用`123456`。

## 安装centos

参考[这里](https://docs.openstack.org/install-guide/environment.html)， 安装两个centos虚拟机，分别为Controller节点(1个处理器，4GB 内存， 5GB硬盘)和Compute节点(1个处理器，2GB内存，10GB硬盘)

参考[这里](https://docs.openstack.org/install-guide/environment-networking.html)。架构中存在两种网络，分别是managment network和provider network。个人理解managment network相当于内网，外部通常无法访问内网服务，但是内网可以访问外网，provider network则直接与外网相连，如果在openstack开启1个instance，那么必须要有一个provider网络的地址，以便于外网来访问这个instance。

因为此处用虚拟机来搭建验证，因此management network采用nat网络(nat网络中虚拟机可以互相访问，但是主机以及外部网络无法访问虚拟机，这里有一点需要注意，nat网络中的ip地址是使用dhcp获取的，似乎无法使用静态地址，尝试过使用静态地址，可以用虚拟机ping通虚拟机，但是无法ping通外部网络，据说nat网络的dns服务也是使用dhcp来实现的，因此如果不使用dhcp就无法使用？)，provider network采用host only来实现(虚拟机之间可以相互访问，主机也可以访问虚拟机)

## 关闭防火墙

1.close-fire-wall.sh

## 配置yum源地址

## reference

[官网地址](https://docs.openstack.org/install-guide/index.html)
