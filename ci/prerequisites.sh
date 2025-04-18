#!/bin/bash

set -eu

# print the hostname to be able to identify runner by logs
echo "HOSTNAME=`hostname`"
echo "TIMESTAMP=$CI_PIPELINE_CREATED_AT"
cat /proc/sys/kernel/core_pattern

apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

apt_packages="build-essential flex bison pkg-config libreadline-dev make gdb libipc-run-perl libicu-dev python3 python3-dev python3-pip python3-setuptools python3-testresources"

if [ $COMPILER = "clang" ]; then
	apt_packages="$apt_packages llvm-$LLVM_VER clang-$LLVM_VER clang-tools-$LLVM_VER"
fi

# install required packages
apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y install -qq $apt_packages
