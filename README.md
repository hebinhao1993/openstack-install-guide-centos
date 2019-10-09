# openstack install guide

这是一份openstack的安装指南，操作系统是centos7。使用virtualbox虚拟机来搭建。为了方便起见，后文但凡出现的密码，均使用`123456`。

## 安装centos

参考[这里](https://docs.openstack.org/install-guide/environment.html)， 安装两个centos虚拟机，分别为Controller节点(1个处理器，4GB 内存， 5GB硬盘)和Compute节点(1个处理器，2GB内存，10GB硬盘)

参考[这里](https://docs.openstack.org/install-guide/environment-networking.html)。架构中存在两种网络，分别是managment network和provider network。个人理解managment network相当于内网，外部通常无法访问内网服务，但是内网可以访问外网，provider network则直接与外网相连，如果在openstack开启1个instance，那么必须要有一个provider网络的地址，以便于外网来访问这个instance。

因为此处用虚拟机来搭建验证，因此management network采用nat网络(nat网络中虚拟机可以互相访问，但是主机以及外部网络无法访问虚拟机，这里有一点需要注意，nat网络中的ip地址是使用dhcp获取的，似乎无法使用静态地址，尝试过使用静态地址，可以用虚拟机ping通虚拟机，但是无法ping通外部网络，据说nat网络的dns服务也是使用dhcp来实现的，因此如果不使用dhcp就无法使用？)，provider network采用host only来实现(虚拟机之间可以相互访问，主机也可以访问虚拟机)

nat网络: virtualbox -> 管理 -> 全局设定 -> 网络 -> 添加新的nat网络 (10.0.2.0/24)
host only: virtualbox -> 管理 -> 主机网络管理器 -> 创建

## 虚拟机内网络设置

如果网络无法使用，则修改/etc/sysconfig/network-scripts/ifcfg-enp3s0，一般来说把onboot改为yes，再重启网络即可

## 安装一些前置软件

```sh
sudo yum install -y git wget
git clone https://github.com/hebinhao1993/openstack-install-guide-centos.git --depth=1
cd openstack-install-guide-centos
```

## 配置yum源地址

参考[阿里开源镜像站](https://opsx.alibaba.com/mirror)

```sh
sudo ./use-aliyun-mirror.sh
```

## 重启一下

```sh
reboot
```

## 关闭防火墙

```sh
sudo ./close-fire-wall.sh
```

## 设置主机名

在controller虚拟机上

```sh
sudo hostnamectl set-hostname controller
```

在compute虚拟机上

```sh
sudo hostnamectl set-hostname compute1
```

## 修改hosts

在controller虚拟机和compute虚拟机上都要修改

```sh
sudo ./configure-name-solution.sh
```

这里需要注意一点，前面已经说过，这里的网络是nat网络，由于采用了dhcp所以，所以每次启动虚拟机，或者虚拟机迁移之后很可能网络地址会改变，那么这里的hosts也需要重新修改。

## NTP

### controller node

## reference

[官网地址](https://docs.openstack.org/install-guide/index.html)
