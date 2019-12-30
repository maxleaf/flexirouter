#!/bin/bash

SCRIPTS_PATH=`pwd`/scripts
VPP_PATH=vpp/build-root/build-vpp_debug-native/vpp/bin

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 WAN_IP WAN_GW_IP LAN_IP"
    exit 2
fi

WAN_IP=$1
WAN_GW_IP=$2
LAN_IP=$3

$VPP_PATH/vppctl exec $SCRIPTS_PATH/init.cli

ifconfig vpp0 $WAN_IP netmask 255.255.255.0
ifconfig vpp1 $LAN_IP netmask 255.255.255.0

ip route add default via $WAN_GW_IP

