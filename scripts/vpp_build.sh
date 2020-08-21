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

rm vpp/src/plugins/netlink
rm vpp/src/plugins/router
ln -sf ../../../vppsb/netlink vpp/src/plugins/netlink
ln -sf ../../../vppsb/router vpp/src/plugins/router

cd vpp

if  [ "${CLEAN}" == "YES" ] ; then
  make wipe
fi
make build

cd -
