#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

$SCRIPTPATH/vpp_build.sh
$SCRIPTPATH/vpp_install.sh
