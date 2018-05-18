#set up static network
ifconfig eno2 140.112.20.182 netmask 255.255.255.0
route add default gw 140.112.20.254
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

#install packstack
yum update -y
yum install -y https://www.rdoproject.org/repos/rdo-release.rpm
yum install -y openstack-packstack
systemctl stop NetworkManager
systemctl disable NetworkManager
yum erase mariadb-libs -y

packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:eno2 --os-neutron-ml2-type-drivers=vxlan,flat --os-heat-install=y
