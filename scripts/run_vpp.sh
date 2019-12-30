#!/bin/bash

SCRIPTS_PATH=vpp/extras/vpp_config/scripts

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 WAN_IP WAN_GW_IP LAN_IP"
    exit 2
fi

WAN_IP=$1
WAN_GW_IP=$2
LAN_IP=$3

/sbin/modprobe uio_pci_generic

ip link set dev enp0s3 down
ip link set dev enp0s8 down

cd vpp

gdb --args ./build-root/build-vpp_debug-native/vpp/bin/vpp -c ../scripts/startup.conf

cd -

python $SCRIPTS_PATH/dpdk-devbind.py -b e1000 00:03.0 00:08.0

ifconfig enp0s3 $WAN_IP netmask 255.255.255.0

ip link set dev enp0s3 up
ip route add default via $WAN_GW_IP
