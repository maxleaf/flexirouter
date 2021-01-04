#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


for i in "$@"
do
case $i in
    --release*)
    RELEASE=--release
    shift
    ;;
    *)
    # unknown option
    ;;
esac
done

$SCRIPTPATH/vpp_build.sh ${RELEASE}
$SCRIPTPATH/vpp_install.sh ${RELEASE}
