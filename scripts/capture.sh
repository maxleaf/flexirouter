#!/bin/bash

VPP_PATH=vpp/build-root/build-vpp_debug-native/vpp/bin

$VPP_PATH/vppctl pcap dispatch trace on max 1000 file vppcapture buffer-trace dpdk-input 1000

sleep 10

$VPP_PATH/vppctl pcap dispatch trace off
