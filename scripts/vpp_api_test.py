#!/usr/bin/env python

# Simple script to get started with VPP Message API interaction and debugging
# Refer :  https://wiki.fd.io/view/VPP/Python_API

import os
import fnmatch
from vpp_papi import VPP 

vpp_json_api_dir = '/usr/share/vpp/api/'
vpp_json_api_files = []

for root, dirnames, filenames in os.walk(vpp_json_api_dir):
    for filename in fnmatch.filter(filenames, '*.api.json'):
        vpp_json_api_files.append(os.path.join(vpp_json_api_dir, filename))

if not vpp_json_api_files:
    print('ERROR: No json api files')
    exit(-1)

vpp = VPP(vpp_json_api_files)

r = vpp.connect("Test")
if r != 0:
    print("ERROR: VPP connect failed")
    exit(-1)

print("Dump interfaces")
print("---------------")
for intf in vpp.api.sw_interface_dump():
    print(intf.interface_name.decode())
    #r = vpp.api.sw_interface_set_dpdk_hqos_pipe(sw_if_index=intf.sw_if_index, subport=0, pipe=0, profile=0)
    #print(r)
    #r = vpp.api.sw_interface_set_dpdk_hqos_pipe_bw(sw_if_index=1, subport=0, pipe=0, bandwidth=100000)
    #print(r)

exit(vpp.disconnect())
