#!/bin/bash

SCRIPTS_PATH=`pwd`/scripts
VPP_PATH=vpp/build-root/build-vpp_debug-native/vpp/bin

cp scripts/50-cloud-init.baseline.yaml /etc/netplan

$VPP_PATH/vppctl exec $SCRIPTS_PATH/init.cli

netplan apply
