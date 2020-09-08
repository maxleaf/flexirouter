#!/bin/bash

set -e  # exit on the first command failure


for i in "$@"
do
case $i in
    -c*|--clean*)
    CLEAN=YES
    shift
    ;;
    *)
          # unknown option
    ;;
esac
done
echo "CLEAN = ${CLEAN}"


cd vpp

VPP_PATH=`pwd`

if  [ "${CLEAN}" == "YES" ] ; then
  make wipe
fi
make build

cd -

cd vppsb
cd netlink

sed -i 's/AM_CFLAGS += -O2.*/AM_CFLAGS += -O2 -DCLIB_VEC64=0/g' Makefile.am

libtoolize
aclocal
autoconf
automake --add-missing
./configure VPP_DIR=$VPP_PATH --enable-debug
make

# Copy it to /usr/lib/ so loader will find it while loading router.so plugin 
if [ -d $VPP_PATH/build-root/build-vpp_debug-native/vpp/lib/ ]; then
  sudo ln -sfn $(pwd)/.libs/librtnl.so $VPP_PATH/build-root/build-vpp_debug-native/vpp/lib/librtnl.so
  sudo ln -sfn $(pwd)/.libs/librtnl.so.0 /usr/lib/x86_64-linux-gnu/librtnl.so.0
fi
if [ -d $VPP_PATH/build-root/build-vpp-native/vpp/lib/ ]; then
  sudo ln -sfn $(pwd)/.libs/librtnl.so $VPP_PATH/build-root/build-vpp-native/vpp/lib/librtnl.so
  sudo ln -sfn $(pwd)/.libs/librtnl.so.0 $VPP_PATH/build-root/build-vpp-native/vpp/lib/librtnl.so.0
fi

cd -

cd router

sed -i 's#AM_CFLAGS = -Wall -I@TOOLKIT_INCLUDE@.*#AM_CFLAGS = -Wall -I@TOOLKIT_INCLUDE@ -DCLIB_DEBUG -DCLIB_VEC64=0 -I../../vpp/build-root/build-vpp_debug-native/vpp -I../../vpp/src -I../netlink#g' Makefile.am

libtoolize
aclocal
autoconf
automake --add-missing
./configure
make

if [ -d $VPP_PATH/build-root/build-vpp_debug-native/vpp/lib/ ]; then
  ln -sfn $(pwd)/.libs/router.so $VPP_PATH/build-root/build-vpp_debug-native/vpp/lib/vpp_plugins/router.so
fi
if [ -d $VPP_PATH/build-root/build-vpp-native/vpp/lib/ ]; then
  ln -sfn $(pwd)/.libs/router.so $VPP_PATH/build-root/build-vpp-native/vpp/lib/vpp_plugins/router.so
fi

cd $VPP_PATH
cd ..
