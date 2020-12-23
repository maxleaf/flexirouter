vppctl exec `pwd`/vxlan.txt

ifconfig vpp2 10.101.0.7 netmask 255.255.255.254
ifconfig vpp3 10.101.0.11 netmask 255.255.255.254

vppctl exec `pwd`/ipsec.txt
